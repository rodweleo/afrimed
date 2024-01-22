import 'package:AfriMed/models/CartItem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AfriMed/providers/cart_provider.dart';

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
        leading: CachedNetworkImage(
          placeholder: (context, url) => const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 50,
          width: 50,
          imageUrl:
          widget.cartItem.product.imageUrl!,
          fit: BoxFit.fill,
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
