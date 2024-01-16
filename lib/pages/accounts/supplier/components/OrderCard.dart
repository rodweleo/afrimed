import 'package:connecta/models/ProductOrder.dart';
import 'package:connecta/pages/accounts/supplier/pages/OrderDetailsPage.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final ProductOrder order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Define colors based on the completed status
    Color backgroundColor;
    Color textColor;

    switch (order.status) {
      case 'COMPLETED':
        backgroundColor = Colors.lightGreen.shade200;
        textColor = Colors.green;
        break;
      case 'IN PROGRESS':
        backgroundColor = const Color(0xFFFFE0B2);
        textColor = Colors.orange;
        break;
      case 'IN TRANSIT':
        backgroundColor = const Color(0xFFFFE0B2);
        textColor = Colors.orange;
        break;
      case 'NOT COMPLETED':
        backgroundColor = Colors.black.withOpacity(0.2);
        textColor = Colors.black;
        break;
      case 'CANCELLED':
        backgroundColor = const Color(0xFFFFCDD2);
        textColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey.shade400;
        textColor = Colors.black;
    }
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.createdOn.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),),
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold, ),
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
                Text(
                    'Products: ${order.products.length}'),
                const SizedBox(width: 10,),
                Text('Price: ${order.totalAmount.toString()}')
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 2.0, right: 8.0, bottom: 2.0, left: 8.0),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(
                    color: textColor,
                  ),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(order.status,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        onTap: () {
          // Implement onTap logic, e.g., navigate to order details page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsPage(productOrder: order)),
          );
        },
      ),
    );
  }
}
