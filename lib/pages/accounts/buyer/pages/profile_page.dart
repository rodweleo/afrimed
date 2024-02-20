import 'package:AfriMed/components/profile/profile_information.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/about_afrimed.dart';
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
    Account? account =
        Provider.of<AuthProvider>(context, listen: false).getCurrentAccount();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Column(
                children: [
                  ProfileInformation(account: account),

                  /// -- MENU
                  Column(
                    children: [
                      ProfileMenuWidget(
                          title: "Wallet",
                          icon: const Icon(Icons.wallet),
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Wallet()),
                            );
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                          title: "Notifications",
                          icon: const Icon(Icons.notifications),
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Notifications()),
                            );
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                          title: "About AfriMed",
                          icon: const Icon(Icons.info),
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AboutAfrimed()));
                          }),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: const Icon(Icons.logout),
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    // Show the logout confirmation dialog
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
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
