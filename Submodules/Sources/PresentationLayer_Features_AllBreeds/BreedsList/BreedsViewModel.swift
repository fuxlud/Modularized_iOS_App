import Foundation
import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem
import PresentationLayer_Features_DetailsScreen
import InfrastructureLayer

@MainActor
@Observable 
public class BreedsViewModel {
    public let id = UUID()
    public var state: ViewState<[BreedViewModel]> = .idle(data: [])
    
    private let breedsUseCase: BreedsUseCaseProtocol
    private let breedDetailsUseCase: BreedDetailsUseCaseProtocol
    private let favoritesUseCase: FetchFavoritesUseCaseProtocol
    private let favoritingUseCase: FavoritingUseCaseProtocol
    
    public init(
        breedsUseCase: BreedsUseCaseProtocol,
        breedDetailsUseCase: BreedDetailsUseCaseProtocol,
        favoritesUseCase: FetchFavoritesUseCaseProtocol,
        favoritingUseCase: FavoritingUseCaseProtocol
    ) {
        self.breedsUseCase = breedsUseCase
        self.breedDetailsUseCase = breedDetailsUseCase
        self.favoritesUseCase = favoritesUseCase
        self.favoritingUseCase = favoritingUseCase
    }
    
    public enum Action {
        case executeOnceOnAppear
    }
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .executeOnceOnAppear:
            await fetchBreeds()
        }
    }
    
    func fetchBreeds() async {
        do {
            let breeds = try await fetchBreedsRemote()
            fillBreeds(breeds)
        } catch let error {
            handleError(error)
        }
    }
    
    func fetchBreedsRemote() async throws -> [BreedEntity] {
        return try await breedsUseCase.getAllBreeds()
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
    private func fillBreeds(_ breeds: [BreedEntity]) {
        let breedsViewModels = breeds.map { BreedViewModel(breed: $0) }
        state = .idle(data: breedsViewModels)
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        guard let error = error as? ErrorEntity else {
            state = .error(message: error.localizedDescription)
            return
        }
        state = .error(message: error.description)
    }
    
    func detailsScreenViewModel(for breedViewModel: BreedViewModel ) -> BreedImagesViewModel {
        let breedName = breedViewModel.title.lowercased()
        return BreedImagesViewModel(breedName: breedName,
                                    breedDetailsUseCase: breedDetailsUseCase,
                                    favoritesUseCase: favoritesUseCase,
                                    favoritingUseCase: favoritingUseCase)
    }
}
