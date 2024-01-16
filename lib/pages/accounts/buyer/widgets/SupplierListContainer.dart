import 'package:flutter/material.dart';

import '../../../../apis/AccountApi.dart';
import '../../../../models/Account.dart';
import 'SupplierCard.dart';

class SupplierListContainer extends StatefulWidget {
  const SupplierListContainer({super.key});

  @override
  State<SupplierListContainer> createState() => _SupplierListContainerState();
}

class _SupplierListContainerState extends State<SupplierListContainer> {
  late Future<List<Account>> _suppliers;

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    AccountApi accountApi = AccountApi();
    // Use your fetchAllSuppliers() function to get the suppliers
    _suppliers = accountApi.fetchAllSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _suppliers,
      builder: (context, AsyncSnapshot<List<Account>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No suppliers available.');
        } else {
          return ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              print(snapshot.data![index]);
              Account account = snapshot.data![index];
              return SupplierCard(account: account);
            },
          );
        }
      },
    );
  }
}
