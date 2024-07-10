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
        container.register(type: BreedsUseCaseProtocol.self, component:
                            BreedsUseCase(repository: BreedsRepository(service: WebService())))
        
        let favoritesManager = FavoritesManager.shared
        let breedDetailsRepository =  BreedDetailsRepository(service: WebService(),
                                                 favoritesManager: favoritesManager)
        container.register(type: FetchFavoritesUseCaseProtocol.self, component:
                            FetchFavoritesUseCase(repository: breedDetailsRepository))
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
        }
    }
}
