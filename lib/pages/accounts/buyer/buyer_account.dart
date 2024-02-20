import 'package:AfriMed/pages/accounts/buyer/pages/profile_page.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/homepage.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/orders_page.dart';
import 'package:AfriMed/services/firebase_cloud_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class BuyerAccount extends StatefulWidget {
  const BuyerAccount({super.key});

  @override
  State<BuyerAccount> createState() => _BuyerAccountState();
}

class _BuyerAccountState extends State<BuyerAccount> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final List pageNames = ['home', 'orders', 'profile'];
  final List<Widget> _pages = [
    const Homepage(),
    const Orders(),
    const Profile(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractiveFCMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    FCMService fcmService = FCMService();
    RemoteMessage? initialMessage = await fcmService.getMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    switch (message.data['type']) {
      case 'order':
        _selectedIndex = 2;
        break;
      default:
        _selectedIndex = 0;
    }
  }

  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);
    setupInteractiveFCMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                label: 'Home',
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                  label: 'Orders',
                  activeIcon: Icon(Icons.shopping_bag)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outlined,
                    color: Colors.white,
                  ),
                  label: 'Profile',
                  activeIcon: Icon(Icons.person))
            ],
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}
