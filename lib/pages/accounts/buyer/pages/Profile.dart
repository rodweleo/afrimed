import 'package:connecta/pages/accounts/buyer/pages/Settings.dart';
import 'package:connecta/pages/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/Account.dart';
import '../../../../providers/user_provider.dart';
import '../widgets/ProfileMenuWidget.dart';
import 'EditProfile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Account? account = Provider.of<UserProvider>(context, listen: false).account;

    Color backgroundColor;
    Color textColor;
    String verificationtext = "";
    switch (account!.isVerified) {
      case true:
        verificationtext = "Verified";
        backgroundColor = Colors.lightGreen.shade200;
        textColor = Colors.green;
        break;
      case false:
        verificationtext = "Not Verified";
        backgroundColor = const Color(0xFFFFCDD2);
        textColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.black;
        textColor = Colors.white;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  const CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                          "https://rickandmortyapi.com/api/character/avatar/144.jpeg")),
                  Positioned(
                    bottom: 7,
                    right: 7,
                    child: Center(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blueGrey),
                        child: IconButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfile(user: user)),
                            );
                          },
                          icon: const Icon(Icons.edit, color: Colors.white),
                        )
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(account != null ? account.name.toString() : '',
                  style: const TextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(account != null ? account.contact.phoneNumber.toString() : '',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        letterSpacing: 1.5,
                      )),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                    const EdgeInsets.only(top: 2.0, right: 8.0, bottom: 2.0, left: 8.0),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(
                          color: textColor,
                        ),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(verificationtext,
                        style:
                        TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 10),

              /// -- MENU
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ProfileMenuWidget(
                        title: "Settings",
                        icon: const Icon(Icons.settings),
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Settings()),
                          );
                        }),
                    const Divider(),
                    ProfileMenuWidget(
                        title: "Billing Details",
                        icon: const Icon(Icons.wallet),
                        onPress: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ProfileMenuWidget(
                        title: "About AfriMed",
                        icon: const Icon(Icons.info),
                        onPress: () {}),
                    const Divider(),
                    ProfileMenuWidget(
                        title: "Logout",
                        icon: const Icon(Icons.logout),
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          // Show the logout confirmation dialog
                          showLogoutDialog(context);
                        }),
                  ],
                ),
              )
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
