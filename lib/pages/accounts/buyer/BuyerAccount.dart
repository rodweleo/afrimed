import 'package:connecta/models/Account.dart';
import 'package:connecta/pages/accounts/buyer/pages/Profile.dart';
import 'package:connecta/pages/accounts/buyer/pages/homepage.dart';
import 'package:connecta/pages/accounts/buyer/pages/Orders.dart';
import 'package:connecta/pages/accounts/buyer/pages/search.dart';
import 'package:connecta/services/firebase_cloud_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../apis/AccountApi.dart';
import '../../../providers/user_provider.dart';

class BuyerAccount extends StatefulWidget {
  const BuyerAccount({super.key});

  @override
  State<BuyerAccount> createState() => _BuyerAccountState();
}

class _BuyerAccountState extends State<BuyerAccount> {
  late Future<Account?> _account;

  void _loadAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    AccountApi _accountApi = new AccountApi();
    // Use await to get the result of the future
    _account = _accountApi.fetchAccountById(user!.uid);

    try {
      // Use await to wait for the future to complete
      Account? loadedAccount = await _account;

      // Check if the loaded account is not null
      if (loadedAccount != null) {
        // Notify the UserProvider with the loaded account data
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setAccount(loadedAccount);
      }
    } catch (error) {
      // Handle any errors that occurred during the future execution
      print("Error loading account: $error");
    }
  }

  final List<Widget> _pages = [
    const Homepage(),
    const Search(),
    const Orders(),
     Profile(),
  ];
  int currentPageIndex = 0;



  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractiveFCMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    FCMService fcmService = new FCMService();
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
    if (message.data['type'] == 'order') {
      currentPageIndex = 2;
    }
  }

  @override
  void initState() {
    setupInteractiveFCMessage();
    _loadAccount();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                  Icons.home,
                  color: Colors.white,
                ),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.search_sharp,
                  color: Colors.white,
                ),
                icon: Icon(Icons.search),
                label: 'Search',
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
                  Icons.person,
                  color: Colors.white,
                ),
                icon: Badge(
                  child: Icon(Icons.person_sharp),
                ),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}
