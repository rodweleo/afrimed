import 'package:connecta/pages/accounts/supplier/widgets/ProfileCard.dart';
import 'package:connecta/pages/accounts/supplier/widgets/profile/ProfileOptions.dart';
import 'package:connecta/pages/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../apis/AccountApi.dart';
import '../../../../models/Account.dart';
import 'package:provider/provider.dart';
import 'package:connecta/providers/user_provider.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  AccountApi _accountApi = new AccountApi();
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
          title: Text('Profile'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
                padding: EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height,
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(children: [
                        ProfileCard(
                          account: account,
                        ),
                        ProfileOptions(),
                      ]),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.2),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          child: const Text('LOGOUT',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3))),
                    )
                  ],
                ),
              )
        );
  }
}
