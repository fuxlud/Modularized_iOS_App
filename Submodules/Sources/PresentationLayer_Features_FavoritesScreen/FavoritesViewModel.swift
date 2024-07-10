import Combine
import Foundation
import DomainLayer
import PresentationLayer_Features_DetailsScreen

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
        case executeOnceOnAppear
    }
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .executeOnceOnAppear:
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
        let detailsCardViewModels = breedDetails.map {
            BreedImageViewModel(breedDetails: $0, favoritingUseCase: DIContainer.shared.resolve(type: FavoritingUseCaseProtocol.self)!)
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
        let detailsCardViewModels = breedDetails.map {
            BreedImageViewModel(breedDetails: $0, favoritingUseCase: DIContainer.shared.resolve(type: FavoritingUseCaseProtocol.self)!)
        }
        state = .idle(data: detailsCardViewModels)
    }
}

extension FavoritesViewModel: @preconcurrency Equatable {
    public static func == (lhs: FavoritesViewModel, rhs: FavoritesViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
