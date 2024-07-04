import Foundation
import Domain

@Observable class DetailsScreenViewModel {
    public let id = UUID()
    public var state: ViewState<[DetailsCardViewModel]> = .idle(data: [])

    private(set) var breed: BreedEntity
    private(set) var favoriteImagesOfBreed = [ImageDetailsEntity]()
    private let breedDetailsUseCase: BreedDetailsUseCaseProtocol

    public init(with breed: BreedEntity,
                breedDetailsUseCase: BreedDetailsUseCaseProtocol) {
        self.breed = breed
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
   
    func fetchBreedDetails() async {
        do {
            let breedDetails = try await fetchBreedDetailsRemote()
            await fillBreedDetails(breedDetails)
        } catch let error {
            await handleError(error)
        }
    }
    
    func fetchBreedDetailsRemote() async throws -> [ImageDetailsEntity] {
        return try await breedDetailsUseCase.getBreedDetails()
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
    private func fillBreedDetails(_ breedDetails: [ImageDetailsEntity]) {
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
