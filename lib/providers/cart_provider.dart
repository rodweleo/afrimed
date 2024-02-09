import 'package:flutter/material.dart';

import '../models/CartItem.dart';
import '../models/SupplierProduct.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  //function to add products to the cart
  void addToCart(CartItem cartItem) {
    // Check if the product is already in the cart
    int existingIndex =
        _cartItems.indexWhere((item) => item.product?.id == cartItem.product?.id);

    if (existingIndex != -1) {
      // If the product is already in the cart, update the quantity
      _cartItems[existingIndex].quantity += cartItem.quantity;
    } else {
      // If the product is not in the cart, add it
      _cartItems.add(cartItem);
    }

    notifyListeners();
  }

  //method to remove items from the cart
  void removeFromCart(CartItem cartItem) {
    // Check if the product is already in the cart
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  //method to get the total quantity of an item in the cart
  int getCartItemQuantity(SupplierProduct product) {
    try {
      CartItem cartItem = _cartItems.firstWhere(
        (item) => item.product == product,
      );
      return cartItem.quantity;
    } catch (e) {
      return 0;
    }
  }

  /*double getTotal({String? supplierId}) {
    double totalAmount = 0.0;

    for (var cartItem in cartItems) {
      if (supplierId == null || cartItem.product?.supplierId == supplierId) {
        totalAmount += cartItem.product!.price * cartItem.quantity;
      }
    }

    return totalAmount;
  }*/

  //method to get the total amount in cash of the items in the cart
  int getTotalAmount() {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }


  //method to retrieve a given supplier's products from the cart
  List<CartItem> getSupplierItemsInCart(String supplierId){
    List<CartItem> items = [];

    for (var cartItem in cartItems) {
      if (cartItem.product!.supplierId == supplierId) {
        items.add(cartItem);
      }
    }
    return items;
  }

  //method to get the total amount worth of products in the cart for a given supplier
  double getSupplierItemsTotalAmount(String sId){
    //get the given supplier's items in the cart
    List<CartItem> items = getSupplierItemsInCart(sId);
    double totalAmount = 0.0;

    if(items.isEmpty){
      totalAmount = 0.0;
      return totalAmount;
    }else{
      //iterate through the items return to get the total amount;
      for (var cartItem in cartItems) {
        totalAmount += cartItem.product!.price * cartItem.quantity;
      }

      return totalAmount;
    }
  }

  //method to clear the cart's items
  void clearCart(){
    _cartItems.clear();
    notifyListeners();
  }


}
