import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:AfriMed/pages/accounts/supplier/widgets/DashboardWidget.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../apis/Order_Api.dart';
import '../../../../models/Account.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //retrieve the supplier's orders and display them here
  final Order_Api orderApi = Order_Api();
  late Future<List<ShoppingOrder>?> _supplierOrders;

  void _handleFetchRequest() {
    _supplierOrders = orderApi.fetchSupplierOrders(
        Provider.of<AuthProvider>(context, listen: false)
            .getCurrentAccount()
            ?.id);
  }

  @override
  void initState() {
    _handleFetchRequest();
    super.initState();
  }

  //for the revenue part of the supplier, we need to add all the amount where the payment is completed

  @override
  Widget build(BuildContext context) {
    Account? account =
        Provider.of<AuthProvider>(context, listen: false).account;
    return Scaffold(
      appBar: AppBar(
        title: Text(account!.businessName),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _supplierOrders,
        builder: (context, AsyncSnapshot<List<ShoppingOrder>?> snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('An error has occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashboardWidget(
                        title: 'Revenue',
                        content: 0.toString(),
                        boxShadowColor: Colors.blueGrey.withOpacity(0.5),
                        endIcon: const Icon(
                          Icons.wallet,
                          color: Colors.green,
                        ),
                        endIconBackground: Colors.lightGreen.withOpacity(0.25),
                      ),
                      DashboardWidget(
                        title: 'Orders',
                        content: snapshot.data!.length.toString(),
                        boxShadowColor: Colors.blueGrey.withOpacity(0.5),
                        endIcon: const Icon(
                          Icons.shopping_bag,
                          color: Colors.orange,
                        ),
                        endIconBackground: const Color(0xFFFFE0B2),
                      ),
                    ],
                  )
                ],
              )),
            );
          } else {
            List<ShoppingOrder>? orderList = snapshot.data!;
            //divide the orders as per the once with the completed payment and not completed
            List<ShoppingOrder> completedPaymentOrders = snapshot.data!
                .where((order) => order.paymentStatus == 'Completed')
                .toList();
            List<ShoppingOrder> notCompletedPaymentOrders = snapshot.data!
                .where((order) => order.paymentStatus == 'Not Completed')
                .toList();
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardWidget(
                          title: 'Revenue',
                          content: "KES 0.00",
                          boxShadowColor: Colors.blueGrey.withOpacity(0.5),
                          endIcon: const Icon(
                            Icons.wallet,
                            color: Colors.green,
                          ),
                          endIconBackground:
                              Colors.lightGreen.withOpacity(0.25),
                        ),
                        DashboardWidget(
                          title: 'Orders',
                          content: orderList.length.toString(),
                          boxShadowColor: Colors.blueGrey.withOpacity(0.5),
                          endIcon: const Icon(
                            Icons.shopping_bag,
                            color: Colors.orange,
                          ),
                          endIconBackground: const Color(0xFFFFE0B2),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Completed Payments vs Not-Completed Payments",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.015),
                    ),
                    SizedBox(
                      height: 250,
                      child: PieChart(PieChartData(
                          centerSpaceRadius: 10,
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 2,
                          sections: [
                            PieChartSectionData(
                              value: completedPaymentOrders.length.toDouble(),
                              color: Colors.green,
                              radius: 100,
                            ),
                            PieChartSectionData(
                              value:
                                  notCompletedPaymentOrders.length.toDouble(),
                              color: Colors.orange,
                              radius: 100,
                            ),
                          ])),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
