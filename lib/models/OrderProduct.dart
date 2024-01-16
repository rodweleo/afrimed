
class OrderProduct {
  final String productId;
  final String supplierId;
  final int orderQuantity;
  final double totalAmount;

  OrderProduct({
    required this.productId,
    required this.supplierId,
    required this.orderQuantity,
    required this.totalAmount
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'supplierId': supplierId,
      'orderQuantity': orderQuantity,
      'totalAmount': totalAmount
    };
  }

  // Named constructor for deserialization
  OrderProduct.fromMap(Map<String, dynamic> map)
      : productId = map['productId'],
        supplierId = map['supplierId'],
        orderQuantity = map['orderQuantity'],
        totalAmount = map['totalAmount'].toDouble();

}