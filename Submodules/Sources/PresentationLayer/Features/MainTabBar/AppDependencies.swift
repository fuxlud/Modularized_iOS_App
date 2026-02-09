import DomainLayer
import InfrastructureLayer

@MainActor
public struct AppDependencies {
    public let breedsUseCase: any BreedsUseCaseProtocol
    public let breedDetailsUseCase: any BreedDetailsUseCaseProtocol
    public let favoritesUseCase: any FetchFavoritesUseCaseProtocol
    public let favoritingUseCase: any FavoritingUseCaseProtocol

    public init(
        breedsUseCase: any BreedsUseCaseProtocol,
        breedDetailsUseCase: any BreedDetailsUseCaseProtocol,
        favoritesUseCase: any FetchFavoritesUseCaseProtocol,
        favoritingUseCase: any FavoritingUseCaseProtocol
    ) {
        self.breedsUseCase = breedsUseCase
        self.breedDetailsUseCase = breedDetailsUseCase
        self.favoritesUseCase = favoritesUseCase
        self.favoritingUseCase = favoritingUseCase
    }

    public static func resolve() -> AppDependencies {
        let container = DIContainer.shared
        guard let breedsUseCase = container.resolve(type: BreedsUseCaseProtocol.self),
              let breedDetailsUseCase = container.resolve(type: BreedDetailsUseCaseProtocol.self),
              let favoritesUseCase = container.resolve(type: FetchFavoritesUseCaseProtocol.self),
              let favoritingUseCase = container.resolve(type: FavoritingUseCaseProtocol.self) else {
            fatalError("Failed to resolve app dependencies.")
        }

        return AppDependencies(
            breedsUseCase: breedsUseCase,
            breedDetailsUseCase: breedDetailsUseCase,
            favoritesUseCase: favoritesUseCase,
            favoritingUseCase: favoritingUseCase
        )
    }
}
