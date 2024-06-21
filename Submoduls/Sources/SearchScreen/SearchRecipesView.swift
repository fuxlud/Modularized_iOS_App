import SwiftUI
import Domain
import DomainMock
import Data
import Networking

public struct SearchRecipesView: View {
    
    @StateObject var viewModel: SearchRecipesViewModel
    
    public init(viewModel: SearchRecipesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @State private var searchText = ""

    public var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Search recipe", text: $searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Button(action: {
                        // Filter action
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()

                Text("Recent Search")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeCard(recipe: recipe)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Search recipes")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                try? await viewModel.loadRecipes()
            }
        }
    }
}

struct RecipeCard: View {
    let recipe: RecipeEntity

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                Color.gray
                    .frame(height: 150)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("Servings: \(recipe.servings) | Ready in \(recipe.readyInMinutes) min")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let repositoryMock = RandomRecipesRepositoryMock()
        let viewModel = SearchRecipesViewModel(repository: repositoryMock)
        SearchRecipesView(viewModel: viewModel)
    }
}
