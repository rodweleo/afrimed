import 'package:connecta/models/ShippingAddress.dart';
import 'package:flutter/material.dart';

class AccountShippingAddress extends StatelessWidget {
  ShippingAddress shippingAddress;
  AccountShippingAddress({super.key, required this.shippingAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(shippingAddress.address,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                MediaQuery.of(context).size.height * 0.02)),
        //Text(shippingAddress.),
        Text(
            '${shippingAddress.town}, ${shippingAddress.county} - Kenya')
      ],
    );
  }
}
