import Foundation
import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem
import PresentationLayer_Features_DetailsScreen
import DataLayer //Should be removed from here. Move to dependency container
import Networking //same

@Observable public class BreedsViewModel {
    public let id = UUID()
    public var state: ViewState<[BreedViewModel]> = .idle(data: [])
    
    private let breedsUseCase: BreedsUseCaseProtocol
    
    public init(breedsUseCase: BreedsUseCaseProtocol) {
        self.breedsUseCase = breedsUseCase
    }
    
    public enum Action {
        case onAppear
    }
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await fetchBreeds()
        }
    }
    
    func fetchBreeds() async {
        do {
            let breeds = try await fetchBreedsRemote()
            await fillBreeds(breeds)
        } catch let error {
            await handleError(error)
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
    
    func detailsScreenViewModel(for breedViewModel: BreedViewModel ) -> DetailsScreenViewModel {
        //Should be moved to dependency container
        let breedName = breedViewModel.title.lowercased()
        let repository =  BreedDetailsRepository(service: WebService(),
                                                 favoritesManager: FavoritesManager.shared)
        let breedDetailsUseCase = BreedDetailsUseCase(repository: repository)
        return DetailsScreenViewModel(breedName: breedName, breedDetailsUseCase: breedDetailsUseCase)
    }
}

extension BreedsViewModel: Equatable {
    public static func == (lhs: BreedsViewModel, rhs: BreedsViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
