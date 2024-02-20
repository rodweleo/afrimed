import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/ui/status.dart';

class OrderCard extends StatelessWidget {
  final ShoppingOrder order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0)),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.createdOn.toString(),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 14),
                ),
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Products: ${order.products.length}'),
                const SizedBox(
                  width: 10,
                ),
                Text('Price: ${order.totalAmount.toPrecision(2)}')
              ],
            ),
            Status(status: order.status)
          ],
        ),
        onTap: () {
          // Implement onTap logic, e.g., navigate to order details page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsPage(order: order)),
          );
        },
      ),
    );
  }
}
