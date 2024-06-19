public protocol RecipesFetcher {
    func fetch() async throws -> [RecipeEntity]
}
