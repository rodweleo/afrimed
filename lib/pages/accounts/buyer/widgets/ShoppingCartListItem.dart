import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../models/CartItem.dart';
import '../../../../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCartListItem extends StatelessWidget {
  ShoppingCartListItem({super.key, required this.cartItem});
  CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          placeholder: (context, url) => const SizedBox(
              height: 5, width: 5, child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height,
          imageUrl: cartItem.product!.thumbnail!,
          fit: BoxFit.contain,
        ),
        title: Text(cartItem.product!.name),
        subtitle: Row(
          children: [
            Text('Qty: ${cartItem.quantity}'),
            const SizedBox(
              width: 20,
            ),
            Text('Amount: ${(cartItem.quantity * cartItem.product!.price).round().toString()}')
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.25),
            borderRadius: BorderRadius.circular(50)
          ),
          child: IconButton(
            onPressed: (){
              //remove the product from the cart
              cartProvider.removeFromCart(cartItem);
            },
            icon: const Icon(Icons.delete, color: Colors.red,),
          ),
        ),
      ),
    );
  }
}
