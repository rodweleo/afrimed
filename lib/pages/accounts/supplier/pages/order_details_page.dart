import 'package:AfriMed/apis/Order_Api.dart';
import 'package:AfriMed/services/ToastService.dart';
import 'package:flutter/material.dart';
import '../../../../components/order/order_details.dart';
import '../../../../components/order/order_summary.dart';
import '../../../../models/ShoppingOrder.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});
  final ShoppingOrder order;

  @override
  Widget build(BuildContext context) {
    Order_Api orderApi = Order_Api();

    Future<void> cancelOrder() async {
      String feedback = await orderApi.cancelOrder(order.id);
      ToastService.showSuccessToast(context, feedback);
    }

    Future<void> confirmOrder() async {
      String feedback = await orderApi.confirmOrder(order.id);
      ToastService.showSuccessToast(context, feedback);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }

    void transportOrder() async {
      String feedback = await orderApi.transportOrder(order.id);
      ToastService.showSuccessToast(context, feedback);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }

    void deliverOrder() async {
      String feedback = await orderApi.deliverOrder(order.id);
      ToastService.showSuccessToast(context, feedback);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
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
            OrderSummary(
              order: order,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: order.status == "CONFIRMED"
              ? SizedBox(
                  width: MediaQuery.of(context).size.width / 2.25,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02)),
                    onPressed: () {
                      transportOrder();
                    },
                    child: const Text('TRANSPORT ORDER'),
                  ),
                )
              : order.status == 'IN TRANSIT'
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width / 2.25,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02)),
                        onPressed: () {
                          deliverOrder();
                        },
                        child: const Text('MARK DELIVERED'),
                      ),
                    )
                  : order.status == "PENDING"
                      ? Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02)),
                                onPressed: () {
                                  cancelOrder();
                                },
                                child: const Text('CANCEL'),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02)),
                                onPressed: () {
                                  confirmOrder();
                                },
                                child: const Text('CONFIRM'),
                              ),
                            )
                          ],
                        )
                      : null),
    );
  }
}
