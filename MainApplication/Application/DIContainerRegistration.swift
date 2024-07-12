import DomainLayer
import Networking
import DataLayer

struct DIContainerRegistration {
  
  static func registerComponents() {
    let container = DIContainer.shared
    let webService = WebService()
    let favoritesManager = FavoritesManager.shared
    let breedDetailsRepository = BreedDetailsRepository(service: webService, favoritesManager: favoritesManager)
    
    container.register(type: BreedsUseCaseProtocol.self, component: BreedsUseCase(repository: BreedsRepository(service: webService)))
    container.register(type: FetchFavoritesUseCaseProtocol.self, component: FetchFavoritesUseCase(repository: breedDetailsRepository))
    container.register(type: FavoritingUseCaseProtocol.self, component: FavoritingUseCase(repository: breedDetailsRepository))
    container.register(type: BreedDetailsUseCaseProtocol.self, component: BreedDetailsUseCase(repository: breedDetailsRepository))
  }
}
