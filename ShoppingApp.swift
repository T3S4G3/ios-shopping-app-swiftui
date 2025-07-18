import SwiftUI

@main
struct ShoppingApp: App {
    // Initialize global state objects
    @StateObject private var cartManager = CartManager()

    var body: some Scene {
        WindowGroup {
            // The ContentView will be wrapped in a NavigationView to support navigation
            NavigationView {
                ContentView()
                    .environmentObject(cartManager)
            }
        }
    }
}
