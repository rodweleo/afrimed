import 'package:AfriMed/components/cards/CartItem.dart';
import 'package:AfriMed/models/Account.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/checkout.dart';
import 'package:AfriMed/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cartProvider.getSupplierItemsInCart(widget.account.id!).length,
          itemBuilder: (context, index) {
            final cartItem = cartProvider.getSupplierItemsInCart(widget.account.id!)[index];
            return ShoppingCartItem(cartItem: cartItem);
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 160,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Items:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(cartProvider
                    .cartItems.length
                    .toString()), // Add your discount logic here
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Price:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(cartProvider
                    .getTotal()
                    .toString()), // Add your discount logic here
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount to Pay:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ksh ${cartProvider.getTotal()}', // You may need to adjust this based on your discount logic
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Checkout()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PROCEED TO CHECKOUT',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
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
