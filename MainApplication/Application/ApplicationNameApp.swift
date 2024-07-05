import SwiftUI
import DomainLayer
import PresentationLayer_Features_AllBreeds
import Networking
import DataLayer
@main

struct ApplicationNameApp: App {
    
    var body: some Scene {
        WindowGroup {
            let repository = BreedsRepository(service: WebService())
            let useCase = BreedsUseCase(repository: repository)
            let viewModel = BreedsViewModel(breedsUseCase: useCase)
            BreedsView(viewModel: viewModel)
        }
    }
}
