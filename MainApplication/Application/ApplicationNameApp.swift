import SwiftUI
import DomainLayer
import PresentationLayer_Features_AllBreeds
import PresentationLayer_Features_MainTabBar
import Networking
import DataLayer

@main

struct ApplicationNameApp: App {
    
    init() {
        let container = DIContainer.shared
        let webService = WebService()
        let favoritesManager = FavoritesManager.shared
        let breedDetailsRepository =  BreedDetailsRepository(service: webService,
                                                 favoritesManager: favoritesManager)
        
        container.register(type: BreedsUseCaseProtocol.self, component:
                            BreedsUseCase(repository: BreedsRepository(service: webService)))
        
        
        container.register(type: FetchFavoritesUseCaseProtocol.self, component:
                            FetchFavoritesUseCase(repository: breedDetailsRepository))
        
        container.register(type: FavoritingUseCaseProtocol.self, component: FavoritingUseCase(repository: breedDetailsRepository))

    }
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
        }
    }
}
