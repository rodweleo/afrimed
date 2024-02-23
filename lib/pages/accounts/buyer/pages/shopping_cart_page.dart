import 'package:AfriMed/models/Account.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/checkout.dart';
import 'package:AfriMed/pages/accounts/buyer/widgets/ShoppingCartListItems.dart';
import 'package:AfriMed/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key, required this.account});
  final Account account;

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bag'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShoppingCartListItems(account: widget.account)),
      bottomNavigationBar: Container(
        height: 160,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Items:',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                Text(cartProvider.cartItems.length
                    .toString()), // Add your discount logic here
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount to Pay:',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  'KES ${cartProvider.getSupplierItemsTotalAmount(widget.account.id).toString()}', // You may need to adjust this based on your discount logic
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: cartProvider
                      .getSupplierItemsInCart(widget.account.id)
                      .isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Checkout(
                                  account: widget.account,
                                )),
                      );
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PROCEED TO CHECKOUT',
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
