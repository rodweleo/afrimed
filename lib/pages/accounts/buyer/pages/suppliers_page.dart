import 'package:flutter/material.dart';
import '../../../../apis/AccountApi.dart';
import '../../../../models/Account.dart';
import '../widgets/SupplierCard.dart';

class Suppliers extends StatefulWidget {
  const Suppliers({super.key});

  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
      ),
      body: FutureBuilder(
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Account account = snapshot.data![index];
                return SupplierCard(account: account);
              },
            );
          }
        },
      ),

    );
  }
}
