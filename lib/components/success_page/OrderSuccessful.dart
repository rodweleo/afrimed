import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class OrderSuccessful extends StatefulWidget {
  const OrderSuccessful({super.key});

  @override
  State<OrderSuccessful> createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Overview',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold))),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 300,
        child: Card(
            color: Colors.green.shade300.withOpacity(0.85),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  badges.Badge(
                      badgeContent:
                          Icon(Icons.check, color: Colors.white, size: 30),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.green.shade300.withOpacity(0.85),
                        padding: EdgeInsets.all(20),
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.white, width: 4),
                      )),
                  SizedBox(height: 20),
                  Text(
                    'Thank you for your order!',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                      'The order confirmation has been sent to your email address and phone number',
                      style: GoogleFonts.poppins(),
                      textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('KSh 250',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                          Text('Total Amount',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ],
                      ),
                      Column(
                        children: [
                          Text('x5',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                          Text('Items Ordered',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ],
                      ),
                      Column(
                        children: [
                          Text('11.06 - 14.06',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                          Text('Est. Delivery',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            shadowColor: Colors.blueGrey),
      ),
    );
  }
}
