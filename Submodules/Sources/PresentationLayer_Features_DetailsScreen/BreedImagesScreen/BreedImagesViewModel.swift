import Foundation
import DomainLayer
import Combine
import DataLayer
import InfrastructureLayer

@MainActor
@Observable
public class BreedImagesViewModel {
    public let id = UUID()
    public var state: ViewState<[BreedImageViewModel]> = .idle(data: [])

    private var breedName: String
    private let breedDetailsUseCase: BreedDetailsUseCaseProtocol
    private let favoritesUseCase: FetchFavoritesUseCaseProtocol
    private let favoritingUseCase: FavoritingUseCaseProtocol

    var items: [BreedImageViewModel] = []
    private var cancellables = Set<AnyCancellable>()

    public init(breedName: String,
                breedDetailsUseCase: BreedDetailsUseCaseProtocol,
                favoritesUseCase: FetchFavoritesUseCaseProtocol,
                favoritingUseCase: FavoritingUseCaseProtocol) {
        self.breedName = breedName
        self.breedDetailsUseCase = breedDetailsUseCase
        self.favoritesUseCase = favoritesUseCase
        self.favoritingUseCase = favoritingUseCase
        subscribeToUpdates()
    }
    
    public enum Action {
        case onAppear
    }
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await fetchBreedDetails()
        }
    }
    
    internal var title: String {
        breedName.capitalized(with: Locale.current)
    }
   
    private func subscribeToUpdates() {
        favoritesUseCase.itemsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                Task {
                    await self?.updateViewModels(with: items)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    private func updateViewModels(with breedDetails: [BreedDetailsEntity]) async {
        
        switch state {
        case .idle(let data):
            for viewModelItem in data {
                
                if breedDetails.first(where: { $0.url == viewModelItem.imageUrl }) != nil
                {
                    if !viewModelItem.breedDetails.isFavorite {
                        viewModelItem.breedDetails.isFavorite = true
                    }
                } else {
                    if viewModelItem.breedDetails.isFavorite {
                        viewModelItem.breedDetails.isFavorite = false
                    }
                }
            }
            state = .idle(data: data)
        default:
            ()
        }
    }
    
    func fetchBreedDetails() async {
        do {
            let breedDetails = try await fetchBreedDetailsRemote()
            fillBreedDetails(breedDetails)
        } catch let error {
            handleError(error)
        }
    }
    
    func fetchBreedDetailsRemote() async throws -> [BreedDetailsEntity] {
        return try await breedDetailsUseCase.getBreedDetails(breedName: breedName)
    }
    
    @MainActor
    private func handleLoading(_ isLoading: Bool) {
        if isLoading {
            state = .loading
        } else {
            if let viewModels = state.data {
                state = .idle(data: viewModels)
                items = viewModels
            }
        }
    }
    
    @MainActor
    private func fillBreedDetails(_ breedDetails: [BreedDetailsEntity]) {
        let detailsCardViewModels = breedDetails.map {
            BreedImageViewModel(breedDetails: $0,
                                favoritingUseCase: favoritingUseCase) }
        state = .idle(data: detailsCardViewModels)
        items = detailsCardViewModels
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        let errorEntity = ErrorMapper.toErrorEntity(error)
        state = .error(message: errorEntity.description)
    }
}
