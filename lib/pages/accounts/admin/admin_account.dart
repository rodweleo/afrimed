import 'package:AfriMed/pages/accounts/admin/pages/home.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/Profile.dart';
import 'package:flutter/material.dart';

class AdminAccount extends StatefulWidget {
  const AdminAccount({super.key});

  @override
  State<AdminAccount> createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  final List<Widget> _pages = [
    const Home(),
    const Profile()
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
          backgroundColor: Colors.black.withOpacity(0.75),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, color: Colors.white,),
                label: 'Dashboard',
                activeIcon: Icon(Icons.home),
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
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ));
  }
}
