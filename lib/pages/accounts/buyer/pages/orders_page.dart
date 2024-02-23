import 'package:AfriMed/apis/Order_Api.dart';
import 'package:AfriMed/components/cards/OrderCard.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/suppliers_page.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/ShoppingOrder.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _loadOrders();
    super.initState();
  }

  Future<List<ShoppingOrder>?> _loadOrders() async {
    Order_Api orderApi = Order_Api();
    // Use your fetchAllOrders() function to get the suppliers
    return orderApi.fetchBuyerOrders(Provider.of<AuthProvider>(context, listen: false).getCurrentAccount()!.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Suppliers()),
            );
          }, icon: const Icon(Icons.add_circle))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Delivered',
            ),
            Tab(
              text: 'In Transit',
            ),
            Tab(
              text: 'Cancelled',
            ),
            Tab(
              text: 'Pending',
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.3),
            child: FutureBuilder(
              future: _loadOrders(),
              builder: (context, AsyncSnapshot<List<ShoppingOrder>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No orders.'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.where((order) => order.status == "DELIVERED").toList().length,
                      itemBuilder: (context, index) {
                        List<ShoppingOrder>? deliveredOrders = snapshot.data?.where((order) => order.status == "DELIVERED").toList();
                        return OrderCard(order: deliveredOrders![index],);
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.3),
            child: FutureBuilder(
              future: _loadOrders(),
              builder: (context, AsyncSnapshot<List<ShoppingOrder>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No orders.'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data?.where((order) => order.status == "IN TRANSIT").length,
                      itemBuilder: (context, index) {
                        List<ShoppingOrder> inTransitOrders = snapshot.data!
                            .where((order) => order.status == 'IN TRANSIT')
                            .toList();
                        return OrderCard(order: inTransitOrders[index],);
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.3),
            child: FutureBuilder(
              future: _loadOrders(),
              builder: (context, AsyncSnapshot<List<ShoppingOrder>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No orders.'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount:
                      snapshot.data!.where((order) => order.status == 'CANCELLED').length,
                      itemBuilder: (BuildContext context, int index) {
                        // Filter the orders based on completion status
                        List<ShoppingOrder> cancelledOrders = snapshot.data!
                            .where((order) => order.status == 'CANCELLED')
                            .toList();
                        return OrderCard(order: cancelledOrders[index]);
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.3),
            child: FutureBuilder(
              future: _loadOrders(),
              builder: (context, AsyncSnapshot<List<ShoppingOrder>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No orders.'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount:
                      snapshot.data!.where((order) => order.status == 'PENDING' || order.status == 'CONFIRMED').length,
                      itemBuilder: (BuildContext context, int index) {
                        // Filter the orders based on completion status
                        List<ShoppingOrder> pendingOrders = snapshot.data!
                            .where((order) => order.status == 'PENDING' || order.status == 'CONFIRMED')
                            .toList();
                        return OrderCard(order: pendingOrders[index]);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      )
    );
  }
}
