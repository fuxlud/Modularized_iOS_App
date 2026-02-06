import SwiftUI
import PresentationLayer_Features_MainTabBar
import DataLayer

@main

struct ApplicationNameApp: App {
    
    private let dependencies: AppDependencies
    
    init() {
        DIContainerRegistration.registerComponents()
        self.dependencies = AppDependencies.resolve()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabBar(dependencies: dependencies)
        }
    }
}
