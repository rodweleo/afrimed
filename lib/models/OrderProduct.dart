
class OrderProduct {
  final String productId;
  final String name;
  final String supplierId;
  final int orderQuantity;
  final double totalAmount;
  final String imageURL;

  OrderProduct({
    required this.name,
    required this.imageURL,
    required this.productId,
    required this.supplierId,
    required this.orderQuantity,
    required this.totalAmount
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'supplierId': supplierId,
      'orderQuantity': orderQuantity,
      'totalAmount': totalAmount,
      'productImageURL': imageURL
    };
  }

  // Named constructor for deserialization
  OrderProduct.fromMap(Map<String, dynamic> map)
      : productId = map['productId'],
        name = map['name'],
        supplierId = map['supplierId'],
        orderQuantity = map['orderQuantity'],
        imageURL = map['productImageURL'],
        totalAmount = map['totalAmount'].toDouble();

}