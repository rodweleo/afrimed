import 'package:AfriMed/components/profile/profile_information.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/Settings.dart';
import 'package:AfriMed/pages/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/Account.dart';
import '../../../../providers/user_provider.dart';
import '../widgets/ProfileMenuWidget.dart';
import 'notifications.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Account? account =
        Provider.of<UserProvider>(context, listen: false).account;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.5),
                                blurRadius: 1,
                                spreadRadius: 0.5,
                                offset: const Offset(1, 1))
                          ]),
                      child: Column(
                        children: [
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
                              title: "Settings",
                              icon: const Icon(Icons.settings),
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Settings()),
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProfileMenuWidget(
                      title: "Logout",
                      icon: const Icon(Icons.logout),
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () {
                        // Show the logout confirmation dialog
                        showLogoutDialog(context);
                      }),
                )
              ],
            ),
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
              performLogout(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

// Function to perform the logout
void performLogout(context) async {
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
  });
}
