import 'package:AfriMed/apis/AccountApi.dart';
import 'package:flutter/material.dart';
import '../../../../models/Account.dart';
import '../widgets/Offers.dart';
import 'supplier_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AccountApi accountApi = AccountApi();


  Future<List<Account>> _loadSuppliers() async {
    return accountApi.fetchAllSuppliers();
  }

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10.0),
            color: Colors.blueGrey.shade200.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Offers(),
                const SizedBox(
                  height: 10,
                ),
                const Text('Featured Suppliers:', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                FutureBuilder(
                  key: const Key("suppliersBuilder"),
                  future: _loadSuppliers(),
                  builder: (context, AsyncSnapshot<List<Account>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('No suppliers found.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Account account = snapshot.data![index];
                          return ListTile(
                              leading: account.imageUrl != ""
                                  ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(account.imageUrl))
                                  : const CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.person),
                              ),
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
                                    builder: (context) =>
                                        SupplierPage(account: account),
                                  ),
                                );
                              });
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
