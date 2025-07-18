import Foundation

class CartManager: ObservableObject {
    @Published var items: [Product] = []

    func add(product: Product) {
        items.append(product)
        print("Added \(product.name) to cart")
    }
    
    func remove(product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items.remove(at: index)
            print("Removed \(product.name) from cart")
        } else {
            // Log error: product not found in cart
            print("Error: Product not found in cart.")
        }
    }
    
    func clearCart() {
        items.removeAll()
        print("Cart cleared")
    }
    
    // Total price calculation
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    // Item count for badge display
    var itemCount: Int {
        items.count
    }
    
    // Check if cart is empty
    var isEmpty: Bool {
        items.isEmpty
    }
    
    // Get quantity of specific product in cart
    func quantity(for product: Product) -> Int {
        items.filter { $0.id == product.id }.count
    }
}
