import 'package:AfriMed/apis/AccountApi.dart';
import 'package:AfriMed/pages/accounts/buyer/BuyerAccount.dart';
import 'package:AfriMed/pages/accounts/supplier/SupplierAccount.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Account.dart';
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

  void _checkAuthentication() async {
    //get the provider of the authentication to check the information
     Account? account = Provider.of<AuthProvider>(context, listen: false).getCurrentAccount();
    await Future.delayed(Duration.zero);
    if (account == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
        if (account.role == 'buyer') {
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

    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('AfriMed')),
    );
  }
}
