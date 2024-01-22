import 'package:AfriMed/apis/Order_Api.dart';
import 'package:AfriMed/components/cards/OrderCard.dart';
import 'package:AfriMed/models/ProductOrder.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/Suppliers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/ui/status.dart';
import '../../../../providers/user_provider.dart';
import '../../supplier/pages/OrderDetailsPage.dart';

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
              text: 'DELIVERED',
            ),
            Tab(
              text: 'SHIPPED',
            ),
            Tab(
              text: 'PENDING',
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
                        return Container(
                          margin: const EdgeInsets.only(top: 5.0),

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.shade500.withOpacity(0.5),
                                blurRadius: 2.5,
                                spreadRadius: 2.5,
                                offset: const Offset(1,1)
                              )
                            ]
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productOrder.createdOn.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),),
                                    Text(
                                      'Order #${productOrder.id}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'Products: ${productOrder.products.length}'),
                                    const SizedBox(width: 10,),
                                    Text('Price: ${productOrder.totalAmount.toString()}')
                                  ],
                                ),
                                Status(
                                    status: productOrder.status
                                )
                              ],
                            ),
                            onTap: () {
                              // Implement onTap logic, e.g., navigate to order details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsPage(productOrder: productOrder)),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.5),
            child: FutureBuilder(
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
          ),
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.5),
            child: FutureBuilder(
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
          ),
          Container(
            color: Colors.blueGrey.shade200.withOpacity(0.5),
            child: FutureBuilder(
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
                        return Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          color: Colors.white,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productOrder.createdOn.toString(), style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),),
                                    Text(
                                      'Order #${productOrder.id}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'Products: ${productOrder.products.length}'),
                                    const SizedBox(width: 10,),
                                    Text('Price: ${productOrder.totalAmount.toString()}')
                                  ],
                                ),
                                Status(
                                    status: productOrder.status
                                )
                              ],
                            ),
                            onTap: () {
                              // Implement onTap logic, e.g., navigate to order details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsPage(productOrder: productOrder)),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Suppliers()),
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
