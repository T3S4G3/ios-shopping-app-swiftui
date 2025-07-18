import Foundation

struct Product: Identifiable, Codable {
    let id: UUID = UUID() // Auto-generated unique identifier
    let name: String
    let description: String
    let price: Double
    let imageName: String  // This will reference an image in Assets.xcassets

    // Static sample data for testing purposes
    static let sampleProducts: [Product] = [
        Product(name: "Stylish T-Shirt", description: "A trendy t-shirt made from 100% organic cotton. Perfect for casual wear and comfortable all day long.", price: 19.99, imageName: "tshirt"),
        Product(name: "Modern Sneakers", description: "Comfortable sneakers with a sleek design. Features breathable material and excellent cushioning for daily activities.", price: 79.99, imageName: "sneakers"),
        Product(name: "Classic Jeans", description: "High-quality denim jeans with a perfect fit. Durable construction and timeless style that never goes out of fashion.", price: 49.99, imageName: "jeans"),
        Product(name: "Wireless Headphones", description: "Premium wireless headphones with noise cancellation. Crystal clear sound quality and long battery life.", price: 129.99, imageName: "headphones"),
        Product(name: "Smart Watch", description: "Advanced smartwatch with fitness tracking, heart rate monitor, and smartphone connectivity.", price: 199.99, imageName: "smartwatch"),
        Product(name: "Leather Wallet", description: "Genuine leather wallet with multiple card slots and bill compartments. Compact design with RFID protection.", price: 34.99, imageName: "wallet")
    ]
}
