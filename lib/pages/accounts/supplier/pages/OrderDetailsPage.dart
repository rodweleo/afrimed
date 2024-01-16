import 'package:connecta/models/ProductOrder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsPage extends StatelessWidget {
  final ProductOrder productOrder;

  const OrderDetailsPage({super.key, required this.productOrder});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        snap: false,
        pinned: true,
        floating: false,
        expandedHeight: 100,
        backgroundColor: Colors.white,
        shadowColor: Colors.blue,
        automaticallyImplyLeading: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 8, bottom: 0),
          title: Text('Order Information',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15))),
        ),
      ),
    ]);
  }
}
