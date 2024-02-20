import 'package:flutter/material.dart';

class CheckoutPaymentInformation extends StatefulWidget {
  const CheckoutPaymentInformation(
      {super.key, required this.onPaymentMethodSelected});

  final Function onPaymentMethodSelected;

  @override
  State<CheckoutPaymentInformation> createState() =>
      _CheckoutPaymentInformationState();
}

class _CheckoutPaymentInformationState
    extends State<CheckoutPaymentInformation> {
  String selectedPaymentMethod = "";
  void selectPaymentMethod(String paymentMethod) {
    setState(() {
      selectedPaymentMethod = paymentMethod;
    });

    //update the selected payment method
    widget.onPaymentMethodSelected(selectedPaymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //display the various options for payment; a. M-Pesa b. Credit
          children: [
            ListTile(
              leading: Radio(
                  value: 'M-Pesa',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    //the radio button for the mpesa payment method
                    selectPaymentMethod('M-Pesa');
                  }),
              title: Text('M-Pesa',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02)),
            ),
            ListTile(
              leading: Radio(
                  value: 'Credit',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    //the radio button for the mpesa payment method
                    selectPaymentMethod('Credit');
                  }),
              title: Text('Credit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02)),
            )
          ],
        )
      ],
    );
  }
}
