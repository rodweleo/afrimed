import 'package:connecta/models/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connecta/providers/cart_provider.dart';

class ShoppingCartItem extends StatefulWidget {
  final CartItem cartItem;
  const ShoppingCartItem({super.key, required this.cartItem});

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
          color: Colors.blueGrey,
          blurRadius: 3.5,
          spreadRadius: 0.5,
          ),
        ]
      ),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: FadeInImage.assetNetwork(
            placeholder: widget.cartItem.product.name,
            image: widget.cartItem.product.imageUrl!,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(widget.cartItem.product.name.toString()),
        subtitle: Text('Quantity: ${widget.cartItem.quantity}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Remove the item from the cart
            cartProvider.removeFromCart(widget.cartItem);
          },
        ),
      ),
    );
  }
}
