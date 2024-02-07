import 'package:AfriMed/pages/accounts/supplier/components/OrderCard.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../apis/Order_Api.dart';
import '../../../../models/ShoppingOrder.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Order_Api _orderApi = Order_Api();

  Future<List<ShoppingOrder>?> _fetchSupplierOrders() async {
    return _orderApi.fetchSupplierOrders(
        Provider.of<AuthProvider>(context, listen: false)
            .getCurrentAccount()
            ?.id);
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _fetchSupplierOrders();
    super.initState();
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
        title: const Text('Orders'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_active_outlined))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'Delivered',
            ),
            Tab(
              text: 'In Transit',
            ),
            Tab(
              text: 'Pending',
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        FutureBuilder<List<ShoppingOrder>?>(
          future: _fetchSupplierOrders(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text('An error has occurred: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No orders available!');
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: snapshot.data![index]);
                  },
                ),
              );
            }
          },
        ),
        FutureBuilder<List<ShoppingOrder>?>(
          future: _fetchSupplierOrders(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text('An error has occurred: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No orders available!');
            } else {
              List<ShoppingOrder> deliveredOrders = snapshot.data!
                  .where((order) => order.status == 'DELIVERED')
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: deliveredOrders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: deliveredOrders[index]);
                  },
                ),
              );
            }
          },
        ),
        FutureBuilder<List<ShoppingOrder>?>(
          future: _fetchSupplierOrders(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text('An error has occurred: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No orders available!');
            } else {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!
                      .where((order) => order.status == 'IN TRANSIT')
                      .length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: snapshot.data!
                        .where((order) => order.status == 'IN TRANSIT').toList()[index]);
                  },
                ),
              );
            }
          },
        ),
        FutureBuilder<List<ShoppingOrder>?>(
          future: _fetchSupplierOrders(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Text('An error has occurred: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No orders available!');
            } else {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!
                      .where((order) => order.status == 'PENDING' || order.status == 'CONFIRMED')
                      .length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: snapshot.data!
                        .where((order) => order.status == 'PENDING' || order.status == 'CONFIRMED').toList()[index]);
                  },
                ),
              );
            }
          },
        )
      ]),
    );
  }
}
