import 'package:AfriMed/pages/accounts/buyer/widgets/ShoppingCartListItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/Account.dart';
import '../../../../providers/cart_provider.dart';

class ShoppingCartListItems extends StatelessWidget {
  ShoppingCartListItems({super.key, required this.account});
  Account account;
  @override
  Widget build(BuildContext context) {

    //getting the items in store for a given supplier when in his/her page
    final cartProvider = Provider.of<CartProvider>(context);
    return ListView.builder(
        itemCount: cartProvider.getSupplierItemsInCart(account.id!).length,
        itemBuilder: (context, int index){
        return ShoppingCartListItem(cartItem: cartProvider.getSupplierItemsInCart(account.id!)[index]);
    });
  }
}
