import 'package:AfriMed/components/order/order_list_item.dart';
import 'package:AfriMed/models/CartItem.dart';
import 'package:flutter/material.dart';

class OrderProducts extends StatelessWidget {
  const OrderProducts({super.key, required this.products});

  final List<CartItem> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Products [${products.length}]',
        style: const TextStyle(
          fontWeight: FontWeight.bold
        ),),
        SizedBox(
          height: 150,
          child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index){
                return OrderListItem(product: products[index],);
              }),
        ),
      ],
    );
  }
}
