import SwiftUI

// Mock data generation
func generateMockRecipes() -> [Recipe] {
    return [
        Recipe(id: 1,
               title: "Traditional spare ribs baked",
               image: "https://example.com/ribs.jpg",
               imageType: "jpg",
               servings: 4,
               readyInMinutes: 120,
               sourceUrl: "https://example.com/recipe1",
               nutrition: [Nutrition(title: "Calories", amount: 500, unit: "kcal")],
               analyzedInstructions: [AnalyzedInstruction(name: "Cooking", steps: [Step(number: 1, step: "Preheat oven", ingredients: [], equipment: [])])]),
        
        Recipe(id: 2,
               title: "Lamb chops with fruity couscous and mint",
               image: "https://example.com/lamb.jpg",
               imageType: "jpg",
               servings: 2,
               readyInMinutes: 45,
               sourceUrl: "https://example.com/recipe2",
               nutrition: [Nutrition(title: "Protein", amount: 30, unit: "g")],
               analyzedInstructions: [AnalyzedInstruction(name: "Preparation", steps: [Step(number: 1, step: "Chop mint", ingredients: [], equipment: [])])]),
        
        Recipe(id: 3,
               title: "Spice roasted chicken with flavored rice",
               image: "https://example.com/chicken.jpg",
               imageType: "jpg",
               servings: 3,
               readyInMinutes: 60,
               sourceUrl: "https://example.com/recipe3",
               nutrition: [Nutrition(title: "Fat", amount: 20, unit: "g")],
               analyzedInstructions: [AnalyzedInstruction(name: "Cooking", steps: [Step(number: 1, step: "Marinate chicken", ingredients: [], equipment: [])])]),
        
        Recipe(id: 4,
               title: "Chinese style Egg fried rice with sliced pork",
               image: "https://example.com/fried_rice.jpg",
               imageType: "jpg",
               servings: 2,
               readyInMinutes: 30,
               sourceUrl: "https://example.com/recipe4",
               nutrition: [Nutrition(title: "Carbs", amount: 70, unit: "g")],
               analyzedInstructions: [AnalyzedInstruction(name: "Cooking", steps: [Step(number: 1, step: "Fry rice", ingredients: [], equipment: [])])]),
        Recipe(id: 5,
               title: "Traditional spare ribs baked",
               image: "https://example.com/ribs.jpg",
               imageType: "jpg",
               servings: 4,
               readyInMinutes: 120,
               sourceUrl: "https://example.com/recipe1",
               nutrition: [Nutrition(title: "Calories", amount: 500, unit: "kcal")],
               analyzedInstructions: [AnalyzedInstruction(name: "Cooking", steps: [Step(number: 1, step: "Preheat oven", ingredients: [], equipment: [])])]),
        
        Recipe(id: 6,
               title: "Lamb chops with fruity couscous and mint",
               image: "https://example.com/lamb.jpg",
               imageType: "jpg",
               servings: 2,
               readyInMinutes: 45,
               sourceUrl: "https://example.com/recipe2",
               nutrition: [Nutrition(title: "Protein", amount: 30, unit: "g")],
               analyzedInstructions: [AnalyzedInstruction(name: "Preparation", steps: [Step(number: 1, step: "Chop mint", ingredients: [], equipment: [])])]),
        
        Recipe(id: 7,
               title: "Spice roasted chicken with flavored rice",
               image: "https://example.com/chicken.jpg",
               imageType: "jpg",
               servings: 3,
               readyInMinutes: 60,
               sourceUrl: "https://example.com/recipe3",
               nutrition: [Nutrition(title: "Fat", amount: 20, unit: "g")],
               analyzedInstructions: [AnalyzedInstruction(name: "Cooking", steps: [Step(number: 1, step: "Marinate chicken", ingredients: [], equipment: [])])]),
        
        Recipe(id: 8,
               title: "Chinese style Egg fried rice with sliced pork",
               image: "https://example.com/fried_rice.jpg",
               imageType: "jpg",
               servings: 2,
               readyInMinutes: 30,
               sourceUrl: "https://example.com/recipe4",
               nutrition: [Nutrition(title: "Carbs", amount: 70, unit: "g")],
               analyzedInstructions: [AnalyzedInstruction(name: "Cooking", steps: [Step(number: 1, step: "Fry rice", ingredients: [], equipment: [])])])
    ]
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var recipes: [Recipe] = []

    var body: some View {
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
                        ForEach(recipes) { recipe in
                            RecipeCard(recipe: recipe)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Search recipes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadRecipes()
            }
        }
    }

    func loadRecipes() {
        // Use mock data for now
        recipes = generateMockRecipes()
    }
}

struct RecipeCard: View {
    let recipe: Recipe

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
        ContentView()
    }
}
