import 'package:flutter/material.dart';
import '../../models/ShoppingOrder.dart';
import 'order_info.dart';
import 'order_products.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});
  final ShoppingOrder order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OrderInfo(order: order),
        const SizedBox(
          height: 10,
        ),
        OrderProducts(products: order.products)
      ]
    );
  }
}
