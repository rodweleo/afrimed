import 'package:AfriMed/components/profile/profile_information.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/Settings.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/Account.dart';
import '../../../../providers/AuthProvider.dart';
import '../../../auth/login.dart';
import '../widgets/ProfileMenuWidget.dart';
import 'notifications.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    Account? account = Provider.of<AuthProvider>(context, listen: false).getCurrentAccount();


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// -- IMAGE
              Column(
                children: [
                  ProfileInformation(account: account),
                  /// -- MENU
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        ProfileMenuWidget(
                            title: "Wallet",
                            icon: const Icon(Icons.wallet),
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const Wallet()),
                              );
                            }),
                        const Divider(),
                        ProfileMenuWidget(
                            title: "Notifications",
                            icon: const Icon(Icons.notifications),
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Notifications()),
                              );
                            }),
                        const Divider(),
                        ProfileMenuWidget(
                            title: "About AfriMed",
                            icon: const Icon(Icons.info),
                            onPress: () {}),
                      ],
                    ),
                  ),
                ],
              ),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: const Icon(Icons.logout),
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    // Show the logout confirmation dialog
                    showLogoutDialog(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Dismiss the dialog
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                textStyle: const TextStyle(
                    color: Colors.white, fontStyle: FontStyle.normal)),
            onPressed: () {
              //perform the logout
              //first, clear the AuthProvider then redirect to the login page
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                    (Route<dynamic> route) => false,
              );
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

// Function to perform the logout
/*void performLogout(context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut().whenComplete(() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (Route<dynamic> route) => false,
    );

    // Close the app when navigating back from the login page
    //SystemNavigator.pop();
  });*/
