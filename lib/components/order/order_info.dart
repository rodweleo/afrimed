import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:flutter/material.dart';
import '../../../../components/ui/status.dart';

class OrderInfo extends StatelessWidget {
  OrderInfo({super.key, required this.order});

  ShoppingOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Order #${order.id}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:
              MediaQuery.of(context).size.height * 0.0225),
        ),
        const SizedBox(
          height: 10,
        ),
        Status(status: order.status),
        const SizedBox(
          height: 10,
        ),
        Text(order.createdOn.toString(), style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary
        )),
      ],
    );
  }
}
