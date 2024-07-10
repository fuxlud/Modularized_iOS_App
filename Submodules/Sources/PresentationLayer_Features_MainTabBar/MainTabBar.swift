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

        let viewModel = FavoritesViewModel(favoritesUseCase: DIContainer.shared.resolve(type: FetchFavoritesUseCaseProtocol.self)!)
        return FavoritesView(viewModel: viewModel)
    }
}
