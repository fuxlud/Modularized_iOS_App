import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem
import PresentationLayer_Features_DetailsScreen

public struct BreedsView: View {
    
    let tileSize: CGFloat = 150
    let spacing: CGFloat = 20
    
    var viewModel: BreedsViewModel
    @State private var selectedBreedViewModel: BreedImagesViewModel?
    
    public init(viewModel: BreedsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [ .init(.adaptive( minimum: tileSize ), spacing: spacing)], spacing: spacing) {
                    if let breedsViewModels = viewModel.state.data {
                        ForEach(breedsViewModels) { breedViewModel in
                            NavigationLink(
                                destination: BreedImagesScreen(viewModel: viewModel.detailsScreenViewModel(for: breedViewModel)),
                                label: {
                                    BreedView(viewModel: breedViewModel)
                                        .frame(height: tileSize)
                                }
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("All 🐶 Breeds")
            .alert(isPresented: .constant(viewModel.state.error != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.state.error ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onViewDidLoad {
                Task {
                    await viewModel.dispatch(.onViewDidLoad)
                }
            }
        }
    }
}

struct BreedsViewWithData_Preview: PreviewProvider {
    static var previews: some View {

        let useCase = BreedsUseCaseMock(breeds: BreedEntity.mock)
        let viewModel = BreedsViewModel(breedsUseCase: useCase)

        BreedsView(viewModel: viewModel)
    }
}

struct BreedsViewWithError_Preview: PreviewProvider {
    static var previews: some View {

        let errorUseCase = BreedsUseCaseMock(error: ErrorEntity.general)
        let viewModel = BreedsViewModel(breedsUseCase: errorUseCase)

        BreedsView(viewModel: viewModel)
    }
}
