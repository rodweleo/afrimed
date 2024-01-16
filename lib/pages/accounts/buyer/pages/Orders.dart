import 'package:connecta/apis/Order_Api.dart';
import 'package:connecta/components/cards/OrderCard.dart';
import 'package:connecta/components/success_page/OrderSuccessful.dart';
import 'package:connecta/models/ProductOrder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<ProductOrder>?> _buyerOrders;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _loadOrders();
    super.initState();
  }

  Future<void> _loadOrders() async {
    Order_Api orderApi = Order_Api();
    // Use your fetchAllOrders() function to get the suppliers
    _buyerOrders = orderApi.fetchBuyerOrders(Provider.of<UserProvider>(context, listen: false).account?.id);
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'COMPLETED',
            ),
            Tab(
              text: 'PENDING',
            ),
            Tab(
              text: 'IN PROGRESS',
            ),

          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder(
            future: _buyerOrders,
            builder: (context, AsyncSnapshot<List<ProductOrder>?> snapshot) {
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      ProductOrder productOrder = snapshot.data![index];
                      return OrderCard(order: productOrder);
                    },
                  ),
                );
              }
            },
          ),
          FutureBuilder(
            future: _buyerOrders,
            builder: (context, AsyncSnapshot<List<ProductOrder>?> snapshot) {
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
                    snapshot.data!.where((order) => order.status == 'COMPLETED').length,
                    itemBuilder: (BuildContext context, int index) {
                      // Filter the orders based on completion status
                      List<ProductOrder> completedOrders = snapshot.data!
                          .where((order) => order.status == 'COMPLETED')
                          .toList();
                      ProductOrder productOrder = completedOrders[index];
                      return OrderCard(order: productOrder);
                    },
                  ),
                );
              }
            },
          ),
          FutureBuilder(
            future: _buyerOrders,
            builder: (context, AsyncSnapshot<List<ProductOrder>?> snapshot) {
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
                    snapshot.data!.where((order) => order.status == 'PENDING').length,
                    itemBuilder: (BuildContext context, int index) {
                      // Filter the orders based on completion status
                      List<ProductOrder> completedOrders = snapshot.data!
                          .where((order) => order.status == 'PENDING')
                          .toList();
                      ProductOrder productOrder = completedOrders[index];
                      return OrderCard(order: productOrder);
                    },
                  ),
                );
              }
            },
          ),
          FutureBuilder(
            future: _buyerOrders,
            builder: (context, AsyncSnapshot<List<ProductOrder>?> snapshot) {
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
                    snapshot.data!.where((order) => order.status == 'IN PROGRESS').length,
                    itemBuilder: (BuildContext context, int index) {
                      // Filter the orders based on completion status
                      List<ProductOrder> completedOrders = snapshot.data!
                          .where((order) => order.status == 'IN PROGRESS')
                          .toList();
                      ProductOrder productOrder = completedOrders[index];
                      return OrderCard(order: productOrder);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderSuccessful()),
          );
        },
        label:
            const Text('Create Order', style: TextStyle(color: Colors.white)),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
