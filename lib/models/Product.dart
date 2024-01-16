class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double discountPercentage;
  final double price;
  final String supplierId;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.stock,
    required this.supplierId,
    required this.category,
    required this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
        discountPercentage: map['discountPercentage'].toDouble(),
      price: map['price'].toDouble(),
      stock: map['stock'],
      category: map['category'],
      imageUrl: map['imageUrl'],
      supplierId: map['supplierId']
      );
  }
}
