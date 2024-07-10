import SwiftUI
import DomainLayer
import Networking
import DataLayer
import PresentationLayer_Features_AllBreeds
import PresentationLayer_Features_DetailsScreen
import PresentationLayer_Features_FavoritesScreen
import DependencyContainer

public struct MainTabBar: View {
    
    public init() {}
    
    public var body: some View {
        TabView {
            allBreedsView
                .tabItem {
                    Label("All Breeds", systemImage: "pawprint")
                }

            favorites
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
    
    var allBreedsView: some View {
        let viewModel = BreedsViewModel(breedsUseCase: DIContainer.shared.resolve(type: BreedsUseCaseProtocol.self)!)
        return BreedsView(viewModel: viewModel)
    }
    
    var favorites: some View {
        let favoritesManager = FavoritesManager.shared
        let repository =  BreedDetailsRepository(service: WebService(),
                                                 favoritesManager: favoritesManager)
        let useCase = FetchFavoritesUseCase(repository: repository)
        let viewModel = FavoritesViewModel(favoritesUseCase: useCase)
        return FavoritesView(viewModel: viewModel)
    }
}
