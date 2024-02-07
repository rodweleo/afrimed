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
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/launcher.png",),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: Column(
          children: [
            Text('AfriMed', textAlign: TextAlign.center, style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.075,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),),
            Text('${DateTime.now().year.toString()}. All Rights Reserved. ', textAlign: TextAlign.center, style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
