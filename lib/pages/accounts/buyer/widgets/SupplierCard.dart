import 'package:flutter/material.dart';

import '../../../../models/Account.dart';
import '../pages/supplier_page.dart';

class SupplierCard extends StatefulWidget {
  final Account account;
  const SupplierCard({super.key, required this.account});

  @override
  State<SupplierCard> createState() => _SupplierCardState();
}

class _SupplierCardState extends State<SupplierCard> {


  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: widget.account.imageUrl != "" ? CircleAvatar(
            radius: 20, backgroundImage: NetworkImage(widget.account.imageUrl))
          : const CircleAvatar(
      radius: 20, child: Icon(Icons.person),),
        title: Text(
          widget.account.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.account.businessInfo.businessCategory),

        onTap: () {
          // Handle tap, navigate to supplier details page, etc.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SupplierPage(account: widget.account),
            ),
          );
        });
  }
}
