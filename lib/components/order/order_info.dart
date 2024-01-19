import 'package:flutter/material.dart';

import '../../models/ProductOrder.dart';
import '../../../../components/ui/status.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.productOrder});

  final ProductOrder productOrder;
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
              'Order #${productOrder.id}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                  MediaQuery.of(context).size.height * 0.0225),
            ),
            Status(status: productOrder.status)
          ],
        ),
        Text(productOrder.createdOn.toString(), style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5)
        )),
      ],
    );
  }
}
