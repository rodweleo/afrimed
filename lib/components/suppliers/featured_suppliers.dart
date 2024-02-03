import 'package:flutter/material.dart';

import '../../apis/AccountApi.dart';
import '../../models/Account.dart';
import '../../pages/accounts/buyer/pages/supplier_page.dart';

class FeaturedSuppliers extends StatefulWidget {
  const FeaturedSuppliers({super.key});

  @override
  State<FeaturedSuppliers> createState() => _FeaturedSuppliersState();
}

class _FeaturedSuppliersState extends State<FeaturedSuppliers> {
  late Future<List<Account>> _suppliers;

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    AccountApi accountApi = AccountApi();
    _suppliers = accountApi.fetchAllSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Account>>(
      key: const Key("suppliersBuilder"),
      future: _suppliers,
      builder: (context, AsyncSnapshot<List<Account>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
          return const Center(child: Text('No suppliers found.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Account account = snapshot.data![index];
              return ListTile(
                  leading: account.imageUrl != "" ? CircleAvatar(
                      radius: 20, backgroundImage: NetworkImage(account.imageUrl))
                      : const CircleAvatar(
                    radius: 20, child: Icon(Icons.person),),
                  title: Text(
                    account.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(account.businessInfo.businessCategory),

                  onTap: () {
                    // Handle tap, navigate to supplier details page, etc.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupplierPage(account: account),
                      ),
                    );
                  });
            },
          );
        }
      },
    );
  }
}
