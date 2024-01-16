import 'package:connecta/apis/AccountApi.dart';
import 'package:flutter/material.dart';
import '../../../../models/Account.dart';
import '../../../../providers/cart_provider.dart';
import '../widgets/Offers.dart';
import '../widgets/SupplierCard.dart';
import 'ShoppingCart.dart';
import 'Suppliers.dart';
import 'notifications.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
    return Scaffold(
      body: Column(
        children: [
          Offers(),
          Flexible(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Featured Suppliers', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04
                      ),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right_rounded, color: Colors.blueGrey,))
                    ],
                  ),
                ),
                FutureBuilder<List<Account>>(
                  key: Key("suppliersBuilder"),
                  future: _suppliers,
                  builder: (context, AsyncSnapshot<List<Account>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('No suppliers found.'));
                    } else {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10), // Separator widget
                        itemBuilder: (BuildContext context, int index) {
                          Account account = snapshot.data![index];
                          return SupplierCard(account: account);
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}

