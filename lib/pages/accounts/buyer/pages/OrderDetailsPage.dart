import 'package:connecta/components/order/order_products.dart';
import 'package:connecta/models/ProductOrder.dart';
import 'package:flutter/material.dart';

import '../../../../components/order/order_details.dart';
import '../../../../components/order/order_info.dart';
import '../../../../components/order/order_summary.dart';

class OrderDetailsPage extends StatelessWidget {
  final ProductOrder productOrder;

  const OrderDetailsPage({super.key, required this.productOrder});

  @override
  Widget build(BuildContext context) {
    void _cancelOrder() {
      print('Cancelling order...');
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderDetails(productOrder: productOrder),
              Column(children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: OrderSummary()),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02)),
                    onPressed: () {
                      _cancelOrder();
                    },
                    child: const Text('CANCEL ORDER'),
                  ),
                )
              ])
            ],
          ),
        ));
  }
}
