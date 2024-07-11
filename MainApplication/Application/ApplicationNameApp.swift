import SwiftUI
import PresentationLayer_Features_MainTabBar

@main

struct ApplicationNameApp: App {
    
    init() {
        DIContainerRegistration.registerComponents()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
        }
    }
}
