import 'package:AfriMed/components/profile/ProfileMenu.dart';
import 'package:AfriMed/components/profile/ProfileMenuWidget.dart';
import 'package:AfriMed/pages/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../apis/AccountApi.dart';
import '../../../../components/profile/profile_information.dart';
import '../../../../models/Account.dart';
import 'package:provider/provider.dart';
import 'package:AfriMed/providers/user_provider.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final AccountApi _accountApi = AccountApi();
  late Future<Account?> account;

  Future<void> _loadAccount() async {
    account = _accountApi.fetchAccountById(user!.uid);
  }

  @override
  void initState() {
    super.initState();
    _loadAccount();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    Account? account = userProvider.account;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                ProfileInformation(account: account),
                const ProfileMenu(),
              ]),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: const Icon(Icons.logout),
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () async {
                    await _auth.signOut();
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
        ));
  }
}
