import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/status.dart';

class OrderCard extends StatelessWidget {
  final ShoppingOrder order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey.shade500.withOpacity(0.5),
                blurRadius: 2.5,
                spreadRadius: 2.5,
                offset: const Offset(1, 1))
          ]),
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
