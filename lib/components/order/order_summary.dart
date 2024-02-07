import 'package:flutter/material.dart';

import '../../models/ShoppingOrder.dart';

class OrderSummary extends StatelessWidget {
  OrderSummary({super.key, required this.order});
  ShoppingOrder order;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Divider(),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1), // Adjust the column width as needed
                1: FlexColumnWidth(1),
              },
              children: [
                TableRow(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SubTotal', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                      )
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order.totalAmount.toString(),
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]),
                const TableRow(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Discount(%)'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('0.0'),
                    ],
                  ),
                ]),
                const TableRow(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivery'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('0.0'),
                    ],
                  ),
                ]),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Total', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Colors.black.withOpacity(0.5)
              ),),
                Text(order.totalAmount.toString(), style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.025,

                ))
              ],
            )
          ]
        ),
      )
    );
  }
}
