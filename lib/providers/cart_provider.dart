import 'package:flutter/material.dart';

import '../models/CartItem.dart';
import '../models/Product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem cartItem) {
    // Check if the product is already in the cart
    int existingIndex =
        _cartItems.indexWhere((item) => item.product.id == cartItem.product.id);

    if (existingIndex != -1) {
      // If the product is already in the cart, update the quantity
      _cartItems[existingIndex].quantity += cartItem.quantity;
    } else {
      // If the product is not in the cart, add it
      _cartItems.add(cartItem);
    }

    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  int getCartItemQuantity(Product product) {
    try {
      CartItem cartItem = _cartItems.firstWhere(
        (item) => item.product == product,
      );
      return cartItem.quantity;
    } catch (e) {
      return 0;
    }
  }

  double getTotal({String? supplierId}) {
    double totalAmount = 0.0;

    for (var cartItem in cartItems) {
      if (supplierId == null || cartItem.product.supplierId == supplierId) {
        totalAmount += cartItem.product.price * cartItem.quantity;
      }
    }

    return totalAmount;
  }

  int getTotalItems() {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  //clear items from the cart
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }



  //get the
}
