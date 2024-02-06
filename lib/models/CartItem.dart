import 'package:AfriMed/models/SupplierProduct.dart';

class CartItem {
  final SupplierProduct? product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toMap() {
    return {
      'product': product?.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: map['product'] != null ? SupplierProduct.fromMap(map['product']) : null,
      quantity: map['quantity'] ?? 1,
    );
  }
}
