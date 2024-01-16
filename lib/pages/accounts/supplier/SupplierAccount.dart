import 'package:connecta/pages/accounts/supplier/pages/Profile.dart';
import 'package:connecta/pages/accounts/supplier/pages/Orders.dart';
import 'package:connecta/pages/accounts/supplier/pages/Products.dart';
import 'package:connecta/pages/accounts/supplier/pages/Dashboard.dart';
import 'package:flutter/material.dart';

class SupplierAccount extends StatefulWidget {
  const SupplierAccount({super.key});

  @override
  State<SupplierAccount> createState() => _SupplierAccountState();
}

class _SupplierAccountState extends State<SupplierAccount> {
  final List<Widget> _pages = [
    Dashboard(),
    const Orders(),
    const Products(),
    Profile(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.black54,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.dashboard_outlined,
                color: Colors.white,
              ),
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            NavigationDestination(
              selectedIcon: Badge(
                label: Text('2'),
                child: Icon(Icons.shopping_bag_sharp, color: Colors.white),
              ),
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.shopping_bag),
              ),
              label: 'Orders',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.category_outlined,
                color: Colors.white,
              ),
              icon: Icon(Icons.category),
              label: 'Products',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              icon: Badge(
                child: Icon(Icons.person_sharp),
              ),
              label: 'Profile',
            ),
          ],
        ));
  }
}
