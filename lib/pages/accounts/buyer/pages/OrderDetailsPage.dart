import 'package:connecta/models/ProductOrder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsPage extends StatelessWidget {
  final ProductOrder productOrder;

  const OrderDetailsPage({super.key, required this.productOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Column(
        children: [],
      )
    );
  }
}
