import Foundation
import Domain

@Observable public class DetailsScreenViewModel {
    public let id = UUID()
    public var state: ViewState<[DetailsCardViewModel]> = .idle(data: [])

    private var breedName: String
    private(set) var favoriteImagesOfBreed = [BreedDetailsEntity]()
    private let breedDetailsUseCase: BreedDetailsUseCaseProtocol

    public init(breedName: String,
                breedDetailsUseCase: BreedDetailsUseCaseProtocol) {
        self.breedName = breedName
        self.breedDetailsUseCase = breedDetailsUseCase
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
            }
        }
    }
    
    @MainActor
    private func fillBreedDetails(_ breedDetails: [BreedDetailsEntity]) {
        let detailsCardViewModels = breedDetails.map { DetailsCardViewModel(imageDetails: $0) }
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
