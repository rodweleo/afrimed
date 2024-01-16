import 'package:connecta/pages/accounts/buyer/BuyerAccount.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

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
                textStyle: const TextStyle(fontWeight: FontWeight.bold))),
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
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Thank you for your order!',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                      'The order confirmation will be sent to your phone number and email address.',
                      style: GoogleFonts.poppins(),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(Provider.of<CartProvider>(context, listen: false).getTotal().toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                          Text('Total Amount',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ],
                      ),
                      Column(
                        children: [
                          Text('x${Provider.of<CartProvider>(context, listen: false).cartItems.length.toString()}',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                          Text('Items Ordered',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ],
                      ),
                      Column(
                        children: [
                          Text('11.06 - 14.06',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14))),
                          Text('Est. Delivery',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ],
                      )
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
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
                        foregroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius:BorderRadius.all(Radius.circular(5.0)))),
                            onPressed: (){
                            },
                            child: const Text('VIEW ORDER')),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const BuyerAccount()),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: const Text('CONTINUE SHOPPING')),
                      )
                    ]
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
