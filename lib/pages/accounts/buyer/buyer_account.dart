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

  final List pageNames = ['homepage', 'orders', 'profile'];
  final List<Widget> _pages = [
    const Homepage(),
    const Orders(),
     const Profile(),
  ];
  int currentPageIndex = 0;



  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractiveFCMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    FCMService fcmService = FCMService();
    RemoteMessage? initialMessage =
    await fcmService.getMessage();

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
    switch(message.data['type']){
      case 'order':
        currentPageIndex = 2;
        break;
      default:
      currentPageIndex = 0;
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
          body: _pages[currentPageIndex],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) async {
              await analytics.logEvent(
                name: 'pages_tracked',
                parameters: {
                  "page_name": pageNames[index],
                  "page_index": index,
                }
              );
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Colors.black54,
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),

              NavigationDestination(
                selectedIcon: Icon(Icons.shopping_bag_sharp, color: Colors.white),
                icon: Icon(Icons.shopping_bag),
                label: 'Orders',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                icon: Icon(Icons.person_sharp),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}