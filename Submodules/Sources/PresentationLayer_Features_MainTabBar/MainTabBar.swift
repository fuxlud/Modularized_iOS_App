import SwiftUI
import DomainLayer
import DataLayer
import InfrastructureLayer
import PresentationLayer_Features_AllBreeds
import PresentationLayer_Features_DetailsScreen
import PresentationLayer_Features_FavoritesScreen

public struct MainTabBar: View {
    
    private let dependencies: AppDependencies
    
    public init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
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
        let viewModel = BreedsViewModel(
            breedsUseCase: dependencies.breedsUseCase,
            breedDetailsUseCase: dependencies.breedDetailsUseCase,
            favoritesUseCase: dependencies.favoritesUseCase,
            favoritingUseCase: dependencies.favoritingUseCase
        )
        return BreedsView(viewModel: viewModel)
    }
    
    var favorites: some View {

        let viewModel = FavoritesViewModel(
            favoritesUseCase: dependencies.favoritesUseCase,
            favoritingUseCase: dependencies.favoritingUseCase
        )
        return FavoritesView(viewModel: viewModel)
    }
}
