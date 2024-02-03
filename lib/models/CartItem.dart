import 'package:AfriMed/models/SupplierProduct.dart';

class CartItem {
  final SupplierProduct? product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
