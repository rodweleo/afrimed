class SupplierProduct {
  final String id;
  final String name;
  final String category;
  final String description;
  final String? thumbnail;
  final List? images;
  final double discountPercentage;
  final double price;
  final int stock;
  final String supplierId;
  SupplierProduct(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.stock,
      required this.category,
      required this.thumbnail,
      required this.images,
        required this.supplierId
      });

  factory SupplierProduct.fromMap(Map<String, dynamic> map) {
    return SupplierProduct(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        discountPercentage: map['discountPercentage'].toDouble(),
        price: map['price'].toDouble(),
        stock: map['stock'],
        category: map['category'],
        thumbnail: map['thumbnail'],
        images: map["images"],
      supplierId: map['supplierId']
    );
  }
}
