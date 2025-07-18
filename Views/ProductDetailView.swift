import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    @State private var showAddedMessage: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Product image placeholder
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .overlay(
                        VStack {
                            Text(String(product.name.prefix(2)))
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.gray)
                            Text("Product Image")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    )
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(product.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(String(format: "$%.2f", product.price))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    
                    Divider()
                    
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                    
                    Spacer(minLength: 20)
                    
                    // Quantity in cart display
                    if cartManager.quantity(for: product) > 0 {
                        HStack {
                            Text("In Cart:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(cartManager.quantity(for: product)) item(s)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // Add to Cart Button
                    Button(action: {
                        cartManager.add(product: product)
                        showAddedMessage = true
                        
                        // Hide message after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showAddedMessage = false
                        }
                    }) {
                        HStack {
                            Text("Add to Cart")
                                .fontWeight(.semibold)
                            
                            if showAddedMessage {
                                Text("✓")
                                    .fontWeight(.bold)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(showAddedMessage ? Color.green : Color.blue)
                        .cornerRadius(10)
                    }
                    .animation(.easeInOut(duration: 0.3), value: showAddedMessage)
                    
                    if showAddedMessage {
                        Text("Added to cart!")
                            .font(.caption)
                            .foregroundColor(.green)
                            .fontWeight(.medium)
                            .transition(.opacity)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CartView().environmentObject(cartManager)) {
                    HStack {
                        Text("Cart")
                            .font(.subheadline)
                        
                        if !cartManager.isEmpty {
                            Text("\(cartManager.itemCount)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Product.sampleProducts.first!
        let cartManager = CartManager()
        NavigationView {
            ProductDetailView(product: sample)
                .environmentObject(cartManager)
        }
    }
}
