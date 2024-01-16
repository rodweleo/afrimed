import 'package:cloud_firestore/cloud_firestore.dart';

import 'OrderProduct.dart';

class ProductOrder {
  final String? id;
  final String buyerId;
  final String supplierId;
  List<OrderProduct> products;
  final double totalAmount;
  final DateTime createdOn;
  final String status;

  ProductOrder({
    required this.id,
      required this.buyerId,
      required this.supplierId,
      required this.products,
      required this.totalAmount,
    required this.createdOn,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'supplierId': supplierId,
      'products': products.map((product) => product.toMap()).toList(),
      'createdOn': createdOn,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  // Named constructor for deserialization
  ProductOrder.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        buyerId = map['buyerId'],
        supplierId = map['supplierId'],
        products = List<OrderProduct>.from(
          (map['products'] as List<dynamic>).map(
                (productMap) => OrderProduct.fromMap(productMap),
          ),
        ),
        createdOn = (map['createdOn'] as Timestamp).toDate(),
        totalAmount = map['totalAmount'].toDouble(),
        status = map['status'];
}
