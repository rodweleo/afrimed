
/*Map<String, List<CartItem>> groupCartItems(cartItems){
  Map<String, List<CartItem>> groupedCartItems = {};
  for(var i = 0; i < cartItems.length; i++){
    //check products in the cart and group them per supplier
    CartItem cartItem = cartItems[i];
    String sId = cartItem.product!.supplierId;

    if(groupedCartItems.containsKey(sId)){
      // If yes, add the cart item to the existing list
      groupedCartItems[sId]?.add(cartItem);
    }else{
      // If no, create a new list with the cart item and add it to the map
      groupedCartItems[sId] = [cartItem];
    }
  }

  return groupedCartItems;
}*/