import 'package:AfriMed/apis/Order_Api.dart';
import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:AfriMed/services/ToastService.dart';
import 'package:flutter/material.dart';
import '../../../../components/order/order_details.dart';
import '../../../../components/order/order_summary.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});

  final ShoppingOrder order;
  @override
  Widget build(BuildContext context) {
    Order_Api orderApi = Order_Api();
    void cancelOrder() async {
      //cancel the order
      //this means we will change the status of the order to cancelled
      //String feedback = await orderApi.cancelOrder(order.id);

      ToastService.showSuccessToast(context, "Order ${order.id} cancelled.");
      Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);
    }

    Future<void> reorder() async {
      print('Re-ordering...');
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
              OrderSummary(
                order: order,
              ),
            ])
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: order.status != 'DELIVERED'
            ? SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02)),
                  onPressed: order.status == 'PENDING'
                      ? () {
                          cancelOrder();
                        }
                      : null,
                  child: const Text('CANCEL ORDER'),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02)),
                  onPressed: () {
                    reorder();
                  },
                  child: const Text('RE-ORDER'),
                ),
              ),
      ),
    );
  }
}
