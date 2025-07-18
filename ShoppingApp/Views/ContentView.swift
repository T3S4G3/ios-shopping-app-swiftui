import SwiftUI

struct ContentView: View {
    // Use sample product data
    let products: [Product] = Product.sampleProducts
    
    // Access the cartManager from the environment
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        VStack {
            List(products) { product in
                NavigationLink(destination: ProductDetailView(product: product)
                                .environmentObject(cartManager)) {
                    HStack {
                        // Product image placeholder
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Text(String(product.name.prefix(1)))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(product.description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            
                            Text(String(format: "$%.2f", product.price))
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        // Show quantity if item is in cart
                        if cartManager.quantity(for: product) > 0 {
                            Text("\(cartManager.quantity(for: product))")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Products")
        .toolbar {
            // Cart button on the top right
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CartView().environmentObject(cartManager)) {
                    HStack {
                        Text("Cart")
                            .fontWeight(.semibold)
                        
                        if !cartManager.isEmpty {
                            Text("\(cartManager.itemCount)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 18, height: 18)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        NavigationView {
            ContentView()
                .environmentObject(cartManager)
        }
    }
}
