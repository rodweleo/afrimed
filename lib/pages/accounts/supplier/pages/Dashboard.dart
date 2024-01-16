import 'package:connecta/pages/accounts/supplier/widgets/DashboardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../apis/Order_Api.dart';
import '../../../../models/ProductOrder.dart';
import '../../../../providers/user_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //retrieve the supplier's orders and display them here
  final Order_Api orderApi = Order_Api();
  late Future<List<ProductOrder>?> _supplierOrders;

  void _handleFetchRequest(){
    _supplierOrders = orderApi.fetchSupplierOrders(Provider.of<UserProvider>(context, listen: false).account?.id);
  }

  @override
  void initState(){
    _handleFetchRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.notifications_active_outlined))
          ]),
      body: FutureBuilder(
        future: _supplierOrders,
        builder: (context, AsyncSnapshot<List<ProductOrder>?>snapshot){
          if(ConnectionState.waiting == snapshot.connectionState){
            return const CircularProgressIndicator();
          } else if(snapshot.hasError){
              return Center(
                child: Text('An error has occurred: ${snapshot.error}')
              );
          }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else{
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardWidget(
                              title: 'Revenue',
                              content: snapshot.data!
                                  .where((element) => element.status == 'completed').toString(),
                              boxShadowColor: Colors.blueGrey.withOpacity(0.5),
                              endIcon: const Icon(
                                Icons.wallet,
                                color: Colors.green,
                              ), endIconBackground: Colors.lightGreen.withOpacity(0.25),
                            ),
                            DashboardWidget(
                              title: 'Orders',
                              content: snapshot.data!.length.toString(),
                              boxShadowColor: Colors.blueGrey.withOpacity(0.5),
                              endIcon: const Icon(
                                Icons.shopping_bag,
                                color: Colors.orange,
                              ), endIconBackground: const Color(0xFFFFE0B2),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            );
          }
        },
      ),
    );
  }
}
