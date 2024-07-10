import SwiftUI

public protocol FeaturesViewModelProtocol {
    associatedtype UseCase
    var useCase: UseCase { get }
    init(useCase: UseCase)
}

public protocol FeaturesViewProtocol: View {
    associatedtype ViewModel: FeaturesViewModelProtocol
    var viewModel: ViewModel { get }
    init(viewModel: ViewModel)
}
