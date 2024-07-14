import Foundation
import DomainLayer
import Combine
import InfrastructureLayer

@Observable
public class BreedImagesViewModel {
    public let id = UUID()
    public var state: ViewState<[BreedImageViewModel]> = .idle(data: [])

    private var breedName: String
    private let breedDetailsUseCase: BreedDetailsUseCaseProtocol
    private let favoritesUseCase: FetchFavoritesUseCaseProtocol

    var items: [BreedImageViewModel] = []
    private var cancellables = Set<AnyCancellable>()

    public init(breedName: String,
                breedDetailsUseCase: BreedDetailsUseCaseProtocol,
                favoritesUseCase: FetchFavoritesUseCaseProtocol) {
        self.breedName = breedName
        self.breedDetailsUseCase = breedDetailsUseCase
        self.favoritesUseCase = favoritesUseCase
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
            await fillBreedDetails(breedDetails)
        } catch let error {
            await handleError(error)
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
                                favoritingUseCase: DIContainer.shared.resolve(type: FavoritingUseCaseProtocol.self)!) }
        state = .idle(data: detailsCardViewModels)
        items = detailsCardViewModels
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        guard let error = error as? ErrorEntity else {
            state = .error(message: error.localizedDescription)
            return
        }
        state = .error(message: error.description)
    }
}

extension BreedImagesViewModel: Equatable {
    public static func == (lhs: BreedImagesViewModel, rhs: BreedImagesViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
