import 'package:AfriMed/models/ShippingAddress.dart';
import 'package:flutter/material.dart';

class AccountShippingAddress extends StatelessWidget {
  ShippingAddress shippingAddress;
  AccountShippingAddress({super.key, required this.shippingAddress, required this.leading});
  Radio leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(shippingAddress.address,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:
              MediaQuery.of(context).size.height * 0.02)),
      subtitle: Text(
          '${shippingAddress.town}, ${shippingAddress.county} - Kenya'),
    );
  }
}
