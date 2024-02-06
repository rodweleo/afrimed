import 'package:AfriMed/pages/accounts/buyer/buyer_account.dart';
import 'package:AfriMed/pages/accounts/supplier/supplier_account.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Account.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
