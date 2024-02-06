
import 'CartItem.dart';
import 'ShippingAddress.dart';

class ShoppingOrder {
  final String id;
  final String buyerId;
  final String supplierId;
  List <CartItem> products;
  final double totalAmount;
  ShippingAddress? shippingAddress;
  final String paymentMethod;
  final String paymentStatus;
  final double discount;
  final String status;
  final String createdOn;

  ShoppingOrder({
    required this.id,
    required this.buyerId,
    required this.supplierId,
    required this.shippingAddress,
    required this.products,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.discount,
    required this.status,
    required this.createdOn
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'supplierId': supplierId,
      'shippingAddress': shippingAddress,
      'products': products,
      'totalAmount': totalAmount,
      'discount': discount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'status': status,
      'createdOn': createdOn
    };
  }

  // Named constructor for deserialization
  ShoppingOrder.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        buyerId = map['buyerId'],
        supplierId = map['supplierId'],
        shippingAddress = ShippingAddress.fromMap(map['shippingAddress']),
        products = List<CartItem>.from((map['products'] as List).map((item) => CartItem.fromMap(item))),
        totalAmount = map['totalAmount'].toDouble(),
        discount = map['discount'].toDouble(),
        paymentMethod = map['paymentMethod'],
        paymentStatus = map['paymentStatus'],
        createdOn = map['createdOn'],
        status = map['status'];
}