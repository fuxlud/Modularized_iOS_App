import SwiftUI
import DomainLayer
import PresentationLayer_Features_AllBreeds
import PresentationLayer_Features_DetailsScreen
import Networking
import DataLayer

public struct MainTabBar: View {
    
    public init() {}
    
    public var body: some View {
        TabView {
            allBreedsView
                .tabItem {
                    Label("All Breeds", systemImage: "pawprint")
                }

            favoriteImages
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
    
    var allBreedsView: some View {
        let repository = BreedsRepository(service: WebService())
        let useCase = BreedsUseCase(repository: repository)
        let viewModel = BreedsViewModel(breedsUseCase: useCase)
        return BreedsView(viewModel: viewModel)
    }
    
    var favoriteImages: some View {
        let repository = BreedDetailsRepository(service: WebService())
        let useCase = BreedDetailsUseCase(repository: repository)
        let viewModel = DetailsScreenViewModel(breedName: "akita", breedDetailsUseCase: useCase)
        return DetailsScreen(viewModel: viewModel)
    }
}
