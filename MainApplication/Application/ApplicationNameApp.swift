import SwiftUI
import DomainLayer
import PresentationLayer_Features_AllBreeds
import PresentationLayer_Features_MainTabBar
import Networking
import DataLayer
import DependencyContainer
@main

struct ApplicationNameApp: App {
    
    init() {
        let container = DIContainer.shared
        container.register(type: BreedsUseCaseProtocol.self, component:
                            BreedsUseCase(repository: BreedsRepository(service: WebService())))        
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
        }
    }
}
