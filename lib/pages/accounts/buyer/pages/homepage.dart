import 'package:AfriMed/apis/AccountApi.dart';
import 'package:AfriMed/components/activities/recent_activities.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top:10.0),
          color: Colors.blueGrey.shade200.withOpacity(0.5),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Offers(),
              ),
              ListTile(
                title: const Text('Featured suppliers', style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                subtitle: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.5),
                          spreadRadius: 2.5,
                          blurRadius: 7,
                          offset: const Offset(0,5), // changes position of shadow
                        ),
                      ]
                  ),
                  child: FutureBuilder<List<Account>>(
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
                  ),
                ),
              ),
              const ListTile(
                title: Text('Recent Activities', style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                subtitle: RecentActivities(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
