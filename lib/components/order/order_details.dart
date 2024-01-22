import 'package:AfriMed/models/ProductOrder.dart';
import 'package:flutter/material.dart';

import 'order_info.dart';
import 'order_products.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.productOrder});
  final ProductOrder productOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderInfo(productOrder: productOrder),
        const SizedBox(
          height: 10,
        ),
        OrderProducts(orderProducts: productOrder.products)
      ]
    );
  }
}
