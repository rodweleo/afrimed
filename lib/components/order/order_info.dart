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
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order #${order.id}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                  MediaQuery.of(context).size.height * 0.0225),
            ),
            Status(status: order.status)
          ],
        ),
        Text(order.createdOn.toString(), style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5)
        )),
      ],
    );
  }
}
