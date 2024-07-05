import SwiftUI
import DomainLayer
import PresentationLayer_Features_AllBreeds
import PresentationLayer_Features_MainTabBar
import Networking
import DataLayer
@main

struct ApplicationNameApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
        }
    }
}
