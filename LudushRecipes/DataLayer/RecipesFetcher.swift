import Models

protocol RecipesFetcher {
    func fetch() async throws -> [Recipe]
}
