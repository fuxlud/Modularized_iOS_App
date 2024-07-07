import Foundation
import DomainLayer
import DataLayer // TODO: Should move to Dependency Container. Is here becouse of FavoritesManager creation
import PresentationLayer_Features_DetailsScreen //TODO: Consider taking out the card into a seperate module
import Networking // TODO: Should move to Dependency Container. Is here becouse of FavoritesManager creation

@Observable public class FavoritesViewModel {
    public let id = UUID()
    public var state: ViewState<[BreedImageViewModel]> = .idle(data: [])

    private let favoritesUseCase: FetchFavoritesUseCase

    public init(favoritesUseCase: FetchFavoritesUseCase) {
        self.favoritesUseCase = favoritesUseCase
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
   
    func fetchBreedDetails() async {
        let breedDetails = await fetchFavoriteBreedDetails()
        await fillBreedDetails(breedDetails)
    }
    
    private func fetchFavoriteBreedDetails() async -> [BreedDetailsEntity] {
        let favorites = await favoritesUseCase.fetchFavorites()
        return favorites
    }
    
    @MainActor
    private func handleLoading(_ isLoading: Bool) {
        if isLoading {
            state = .loading
        } else {
            if let viewModels = state.data {
                state = .idle(data: viewModels)
            }
        }
    }
    
    @MainActor
    private func fillBreedDetails(_ breedDetails: [BreedDetailsEntity]) {
        let repository = BreedDetailsRepository(service: WebService(), favoritesManager: FavoritesManager.shared) //Move to Devendency container
        let favoritingUseCase = FavoriteUseCase(repository: repository)
        let detailsCardViewModels = breedDetails.map { BreedImageViewModel(breedDetails: $0,
                                                                            favoritingUseCase: favoritingUseCase) }
        state = .idle(data: detailsCardViewModels)
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
