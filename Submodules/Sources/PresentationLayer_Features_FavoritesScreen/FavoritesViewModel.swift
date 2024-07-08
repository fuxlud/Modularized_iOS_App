import Combine
import Foundation
import DomainLayer
import DataLayer // TODO: Should move to Dependency Container. Is here becouse of FavoritesManager creation
import PresentationLayer_Features_DetailsScreen //TODO: Consider taking out the card into a seperate module
import Networking // TODO: Should move to Dependency Container. Is here becouse of FavoritesManager creation

@MainActor
@Observable public class FavoritesViewModel {
    public let id = UUID()
    public var state: ViewState<[BreedImageViewModel]> = .idle(data: [])
    
    private let favoritesUseCase: FetchFavoritesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(favoritesUseCase: FetchFavoritesUseCaseProtocol) {
        self.favoritesUseCase = favoritesUseCase
        subscribeToUpdates()
    }
    
    public enum Action {
        case onViewDidLoad
    }
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .onViewDidLoad:
            await fetchBreedDetails()
        }
    }
    
    internal var title: String {
        "Favorite Images"
    }
    
    private func subscribeToUpdates() {
        favoritesUseCase.itemsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                Task {
                    self?.updateViewModels(with: items)
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchBreedDetails() async {
        let breedDetails = await fetchFavoriteBreedDetails()
        fillBreedDetails(breedDetails)
    }
    
    private func fetchFavoriteBreedDetails() async -> [BreedDetailsEntity] {
        return await favoritesUseCase.fetchFavorites()
    }
    
    private func handleLoading(_ isLoading: Bool) {
        if isLoading {
            state = .loading
        } else {
            if let viewModels = state.data {
                state = .idle(data: viewModels)
            }
        }
    }
    
    private func fillBreedDetails(_ breedDetails: [BreedDetailsEntity]) {
        let repository = BreedDetailsRepository(service: WebService(), favoritesManager: FavoritesManager.shared) //Move to Devendency container
        let favoritingUseCase = FavoriteUseCase(repository: repository)
        let detailsCardViewModels = breedDetails.map {
            BreedImageViewModel(breedDetails: $0, favoritingUseCase: favoritingUseCase)
        }
        state = .idle(data: detailsCardViewModels)
    }
    
    private func handleError(_ error: Error) {
        guard let error = error as? ErrorEntity else {
            state = .error(message: error.localizedDescription)
            return
        }
        state = .error(message: error.description)
    }
    
    private func updateViewModels(with breedDetails: [BreedDetailsEntity]) {
        let repository = BreedDetailsRepository(service: WebService(), favoritesManager: FavoritesManager.shared)
        let favoritingUseCase = FavoriteUseCase(repository: repository)
        let detailsCardViewModels = breedDetails.map {
            BreedImageViewModel(breedDetails: $0, favoritingUseCase: favoritingUseCase)
        }
        state = .idle(data: detailsCardViewModels)
    }
}

extension FavoritesViewModel: @preconcurrency Equatable {
    public static func == (lhs: FavoritesViewModel, rhs: FavoritesViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
