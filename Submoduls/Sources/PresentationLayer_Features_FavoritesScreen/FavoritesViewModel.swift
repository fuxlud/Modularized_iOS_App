import Foundation
import DomainLayer
import DataLayer // TODO: Should move to Dependency Container. Is here becouse of FavoritesManager creation
import PresentationLayer_Features_DetailsScreen //TODO: Consider taking out the card into a seperate module

@Observable public class FavoritesViewModel {
    public let id = UUID()
    public var state: ViewState<[DetailsCardViewModel]> = .idle(data: [])

    private let favoritesUseCase: FavoritesUseCaseProtocol

    public init(favoritesUseCase: FavoritesUseCaseProtocol) {
        self.favoritesUseCase = favoritesUseCase
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
        "Favorite Images"
    }
   
    func fetchBreedDetails() async {
        let breedDetails = await fetchFavoriteBreedDetails()
        await fillBreedDetails(breedDetails)
    }
    
    private func fetchFavoriteBreedDetails() async -> [BreedDetailsEntity] {
        let favorites = await favoritesUseCase.fatchFavorites()
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
        let detailsCardViewModels = breedDetails.map { DetailsCardViewModel(breedDetails: $0,
                                                                            favoritingUseCase: favoritesUseCase) }
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

extension DetailsScreenViewModel: Equatable {
    public static func == (lhs: DetailsScreenViewModel, rhs: DetailsScreenViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
