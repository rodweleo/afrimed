import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [
          // Recent notifications
          ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: const Text('New order confirmation'),
            subtitle: const Text('Your order for 10 items has been confirmed.'),
            onTap: () {
              // Go to order details page
            },
          ),

          ListTile(
            leading: const Icon(Icons.ac_unit),
            title: const Text('Shipping update'),
            subtitle: const Text('Your order has shipped and is on its way.'),
            onTap: () {
              // Go to shipping details page
            },
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Product recommendation'),
            subtitle: const Text('We think you might like this product.'),
            onTap: () {
              // Go to product details page
            },
          ),
        ],
      ),
    );
  }
}
