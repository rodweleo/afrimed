import 'package:flutter/material.dart';
import '../../../../components/order/order_details.dart';
import '../../../../components/order/order_summary.dart';
import '../../../../models/ShoppingOrder.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});
  final ShoppingOrder order;



  @override
  Widget build(BuildContext context) {
    void cancelOrder() {
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
              OrderDetails(order: order),
              Column(children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: OrderSummary(order: order,)),
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
                    onPressed: order.status != 'PENDING' ? (){
                      cancelOrder();
                    } : null,
                    child: const Text('CANCEL ORDER'),
                  ),
                )
              ])
            ],
          ),
        ));
  }
}