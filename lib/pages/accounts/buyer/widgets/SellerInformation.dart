import 'package:AfriMed/apis/AccountApi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Account.dart';
import '../../../../models/Product.dart';

class SellerInformation extends StatefulWidget {
  const SellerInformation({super.key, required this.product});

  final Product product;

  @override
  State<SellerInformation> createState() => _SellerInformationState();
}

class _SellerInformationState extends State<SellerInformation> {
  //fetch the details of the supplier using the id in the product object
  late Future<Account?> _supplier;

  void _fetchSupplierDetails() async {
    AccountApi accountApi = AccountApi();
    _supplier = accountApi.fetchAccountById(widget.product.supplierId);
  }

  @override
  void initState() {
    _fetchSupplierDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Account?>(
        future: _supplier,
        builder: (context, AsyncSnapshot<Account?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return const Center(child: Text('No supplier found.'));
          } else {
            Account? account = snapshot.data;
            return ListTile(
              leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(account!.imageUrl)),
              title: Text(
                account.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                '96 positive feedbacks',
                style: TextStyle(
                  color: Colors
                      .green, // Assuming positive feedback is associated with green color
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.5),
                      border: Border.all(
                          color: Colors.blueGrey.shade500.withOpacity(0.5),
                          width: 1.5),
                    ),
                    child: const Icon(
                      Icons.call,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.5),
                      border: Border.all(
                          color: Colors.blueGrey.shade500.withOpacity(0.5),
                          width: 1.5),
                    ),
                    child: const Icon(
                      Icons.message,
                      color: Colors.blueGrey,
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
