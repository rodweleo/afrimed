import '../../../../models/CartItem.dart';

Map<String, List<CartItem>> groupCartItems(_cartItems){
  Map<String, List<CartItem>> groupedCartItems = {};
  for(var i = 0; i < _cartItems.length; i++){
    //check products in the cart and group them per supplier
    CartItem _cartItem = _cartItems[i];
    String sId = _cartItem.product.supplierId;

    if(groupedCartItems.containsKey(sId)){
      // If yes, add the cart item to the existing list
      groupedCartItems[sId]?.add(_cartItem);
    }else{
      // If no, create a new list with the cart item and add it to the map
      groupedCartItems[sId] = [_cartItem];
    }
  }

  return groupedCartItems;
}