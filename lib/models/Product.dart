class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final String? thumbnail;
  final List? images;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.thumbnail,
      required this.images,
      });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        category: map['category'],
        thumbnail: map['thumbnail'],
        images: map["images"],
    );
  }
}
