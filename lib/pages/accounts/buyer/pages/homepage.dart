import 'package:connecta/apis/AccountApi.dart';
import 'package:flutter/material.dart';
import '../../../../models/Account.dart';
import '../widgets/Offers.dart';
import '../widgets/SupplierCard.dart';
import 'ShoppingCart.dart';
import 'Suppliers.dart';
import 'notifications.dart';

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
    // Use your fetchProducts() function to get the products
    _suppliers = accountApi.fetchAllSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: false,
                background: Offers(),
              ), //FlexibleSpaceBar
              expandedHeight: 300,
              backgroundColor: Colors.blueGrey,
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                tooltip: 'Menu',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ), //IconButton

              shadowColor: Colors.blueGrey,
              automaticallyImplyLeading: false,
              actions: [
                Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white.withOpacity(0.8)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShoppingCart()),
                        );
                      },
                    ),
                    Positioned(
                        top: 2.5,
                        right: 5,
                        child: Container(
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text("0",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.035)),
                          ),
                        ))
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.white.withOpacity(0.8)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notifications()),
                        );
                      },
                    ),
                    Positioned(
                        top: 2.5,
                        right: 5,
                        child: Container(
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Center(
                            child: Text("0",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                    MediaQuery.of(context).size.width * 0.035)),
                          ),
                        ))
                  ],
                ),
              ],
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Suppliers',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Suppliers(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ))
                          ]),
                    ),
                  ))),
          SliverFillRemaining(
            child: FutureBuilder(
              future: _suppliers,
              builder: (context, AsyncSnapshot<List<Account>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Account account = snapshot.data![index];
                      return SupplierCard(account: account);
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(''),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    ListTile(
                      leading: Icon(Icons.wallet_outlined),
                      title: const Text('Wallet'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.receipt_outlined),
                      title: const Text('Reports'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      height: 0.25,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outlined),
                      title: const Text('Help Center'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShoppingCart(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.feedback_outlined),
                      title: const Text('Feedback'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]),
                  Text('Powered by AfriMed ${DateTime.now().year}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
