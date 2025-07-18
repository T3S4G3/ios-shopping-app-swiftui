import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showCheckoutAlert = false

    var body: some View {
        VStack {
            if cartManager.isEmpty {
                // Empty cart state
                VStack(spacing: 20) {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text("🛒")
                                .font(.system(size: 40))
                        )
                    
                    Text("Your cart is empty")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text("Add some products to get started")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            } else {
                // Cart items list
                List {
                    ForEach(cartManager.items) { item in
                        HStack {
                            // Product image placeholder
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Text(String(item.name.prefix(1)))
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.body)
                                    .fontWeight(.medium)
                                
                                Text(String(format: "$%.2f", item.price))
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    cartManager.remove(product: item)
                                }
                            }) {
                                Text("Remove")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.red)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                
                // Cart summary and checkout section
                VStack(spacing: 16) {
                    Divider()
                    
                    // Total section
                    HStack {
                        Text("Total (\(cartManager.itemCount) item\(cartManager.itemCount == 1 ? "" : "s")):")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Text(String(format: "$%.2f", cartManager.totalPrice))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal)
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        // Clear cart button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                cartManager.clearCart()
                            }
                        }) {
                            Text("Clear Cart")
                                .fontWeight(.medium)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        // Checkout button
                        Button(action: {
                            showCheckoutAlert = true
                        }) {
                            Text("Checkout")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Shopping Cart")
        .alert("Checkout", isPresented: $showCheckoutAlert) {
            Button("Continue Shopping", role: .cancel) { }
            Button("Proceed") {
                // Implement checkout logic here
                print("Proceeding to checkout with total: $\(String(format: "%.2f", cartManager.totalPrice))")
                cartManager.clearCart()
            }
        } message: {
            Text("Total: $\(String(format: "%.2f", cartManager.totalPrice))\n\nProceed to checkout?")
        }
    }
    
    // Function to handle swipe-to-delete
    func deleteItems(offsets: IndexSet) {
        withAnimation(.easeInOut(duration: 0.3)) {
            for index in offsets {
                cartManager.remove(product: cartManager.items[index])
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        // Add some sample items for preview
        cartManager.add(product: Product.sampleProducts[0])
        cartManager.add(product: Product.sampleProducts[1])
        
        return NavigationView {
            CartView()
                .environmentObject(cartManager)
        }
    }
}
