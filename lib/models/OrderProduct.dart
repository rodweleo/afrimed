
class OrderProduct {
  final String productId;
  final String name;
  final String supplierId;
  final int orderQuantity;
  final double totalAmount;
  final String thumbnail;

  OrderProduct({
    required this.name,
    required this.thumbnail,
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
      'thumbnail': thumbnail
    };
  }

  // Named constructor for deserialization
  OrderProduct.fromMap(Map<String, dynamic> map)
      : productId = map['productId'],
        name = map['name'],
        supplierId = map['supplierId'],
        orderQuantity = map['orderQuantity'],
        thumbnail = map['thumbnail'],
        totalAmount = map['totalAmount'].toDouble();

}