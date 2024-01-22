import 'package:AfriMed/apis/AccountApi.dart';
import 'package:AfriMed/pages/accounts/buyer/BuyerAccount.dart';
import 'package:AfriMed/pages/accounts/supplier/SupplierAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Authenticator extends StatefulWidget {
  const Authenticator({super.key});

  @override
  _AuthenticatorState createState() => _AuthenticatorState();
}

class _AuthenticatorState extends State<Authenticator> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    print(user);
    await Future.delayed(Duration.zero); // Ensure the build is complete

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      String? role = await AccountApi().fetchUserRoleById(user.uid);
      if (role != null) {
        // Replace the following lines with your own logic for navigation
        if (role == 'buyer') {
          // Navigate to buyer page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BuyerAccount()),
          );
        } else {
          // Navigate to regular user page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SupplierAccount()),
          );
        }
      } else {
        // Role not available, navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splashscreen')),
    );
  }
}
