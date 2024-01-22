import 'package:AfriMed/models/ProductOrder.dart';
import 'package:AfriMed/pages/accounts/supplier/components/OrderCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../apis/Order_Api.dart';
import '../../../../providers/user_provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<ProductOrder>?> _supplierOrders;


  final Order_Api _orderApi = Order_Api();

  Future<void> _fetchSupplierOrders()async {
    _supplierOrders = _orderApi.fetchSupplierOrders(Provider.of<UserProvider>(context, listen: false).account?.id);
  }
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
              onPressed: () {

              },
              icon: const Icon(Icons.notifications_active_outlined))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Total Orders',
            ),
            Tab(
              text: 'Pending Orders',
            ),
            Tab(
              text: 'Placed Orders',
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        FutureBuilder<List<ProductOrder>?>(
          future: _supplierOrders,
          builder: (context, snapshot){
            if(ConnectionState.waiting == snapshot.connectionState){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text('An error has occurred: ${snapshot.error}');
            }else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return const Text('No orders available!');
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return OrderCard(order: snapshot.data![index]);
                    },
                ),
              );
            }
          },
        ),
        FutureBuilder<List<ProductOrder>?>(
          future: _supplierOrders,
          builder: (context, snapshot){
            if(ConnectionState.waiting == snapshot.connectionState){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text('An error has occurred: ${snapshot.error}');
            }else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return const Text('No orders available!');
            }else{
              List<ProductOrder> pendingOrders = snapshot.data!.where((order) => order.status == 'PENDING').toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: pendingOrders.length,
                  itemBuilder: (context, index){
                    return OrderCard(order: pendingOrders[index]);
                  },
                ),
              );
            }
          },
        ),
        FutureBuilder<List<ProductOrder>?>(
          future: _supplierOrders,
          builder: (context, snapshot){
            if(ConnectionState.waiting == snapshot.connectionState){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text('An error has occurred: ${snapshot.error}');
            }else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return const Text('No orders available!');
            }else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.where((order) => order.status == 'IN TRANSIT').length,
                  itemBuilder: (context, index){
                    return OrderCard(order: snapshot.data![index]);
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
