import 'package:flutter/material.dart';

class CheckoutPaymentInformation extends StatelessWidget {
  const CheckoutPaymentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(top: 0, bottom: 16.0, left: 16.0, right: 16.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Jane Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.02)),
                  const Text('qwert'),
                  TextButton(
                      onPressed: (){
                        print('Change the shipping address information');
                      }, child: Text('Change', style: TextStyle(
                      color: Colors.red.shade300,
                      fontWeight: FontWeight.bold
                  ))),
                ],
              ),

            ],
          ),
        )
      ],
    );
  }
}
