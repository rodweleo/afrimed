import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:AfriMed/pages/accounts/buyer/buyer_account.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../providers/AuthProvider.dart';

class OrderSuccessful extends StatefulWidget {
  OrderSuccessful({super.key, required this.newOrder, required this.orderId});

  ShoppingOrder newOrder;
  String orderId;

  @override
  State<OrderSuccessful> createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Overview',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset('assets/images/LottieSuccess.json',
                fit: BoxFit.fill),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Thank you for your order!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Text(
                    'Your order has been received successfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Details', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045
                      ),),
                      SizedBox(
                        width: double.infinity,
                        child: Table(
                          border: TableBorder.all(color: Colors.transparent),
                          children: [
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order number:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.orderId, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Items Orders:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.newOrder.products.length.toString(), style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Amount:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.newOrder.totalAmount.toString(), style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date:',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.newOrder.createdOn, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email Address:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Provider.of<AuthProvider>(context).getCurrentAccount()!.id!, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Payment Method:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.newOrder.paymentMethod, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Payment Status:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.newOrder.paymentStatus, style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                                ],
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Est Delivery:',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('24Hrs', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                                ],
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.white,
                                  foregroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)))),
                              onPressed: () {},
                              child: const Text('VIEW ORDER', style: TextStyle(
                                color: Colors.black
                              ))),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 30) / 2,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BuyerAccount()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: const Text('GO HOME')),
                        )
                      ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
