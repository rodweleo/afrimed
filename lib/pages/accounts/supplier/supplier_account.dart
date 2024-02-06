import 'package:AfriMed/pages/accounts/supplier/pages/Profile.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/orders_page.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/supplier_products.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/dashboard.dart';
import 'package:flutter/material.dart';

class SupplierAccount extends StatefulWidget {
  const SupplierAccount({super.key});

  @override
  State<SupplierAccount> createState() => _SupplierAccountState();
}

class _SupplierAccountState extends State<SupplierAccount> {
  final List<Widget> _pages = [
    const Dashboard(),
    const Orders(),
    const SupplierProductsPage(),
    const Profile(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined, color: Colors.white,),
                label: 'Dashboard',
                activeIcon: Icon(Icons.dashboard),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                label: 'Orders',
                activeIcon: Icon(Icons.shopping_bag)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined, color: Colors.white,),
                label: 'Products',
                activeIcon: Icon(Icons.category)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined, color: Colors.white,),
                label: 'Profile',
              activeIcon: Icon(Icons.person)
            )
          ],
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ));
  }
}
