import 'package:AfriMed/apis/AccountApi.dart';
import 'package:AfriMed/pages/accounts/buyer/BuyerAccount.dart';
import 'package:AfriMed/pages/accounts/supplier/SupplierAccount.dart';
import 'package:AfriMed/pages/auth/register.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AfriMed',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.04),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.black.withOpacity(0.75)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _usernameController,
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          _usernameController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'Username',
                          suffixIcon: _usernameController.text.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : null),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _passwordController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.vpn_key_rounded),
                          suffixIcon: _passwordController.text.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : null),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04)),
                          onPressed: () async {
                            //check whether there is any error in the form
                            if (_loginFormKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );

                              //login with username and password
                              AccountApi accountApi = AccountApi();
                              Account? account = await accountApi
                                  .signInWithUsernameAndPassword(
                                      _usernameController.text,
                                      _passwordController.text);
                              if (account != null) {
                                //this means the account has been found successfully, redirect to the appropriate account page
                                switch (account.role) {
                                  case 'buyer':
                                    //set the auth provider to contain the details of the current account
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setLoggedInAccount(account);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BuyerAccount()),
                                      (Route<dynamic> route) => false,
                                    );

                                    break;
                                  case 'supplier':
                                    //set the auth provider to contain the details of the current account
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setLoggedInAccount(account);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SupplierAccount()),
                                      (Route<dynamic> route) => false,
                                    );
                                    break;
                                  default:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                }
                              }
                            }
                          },
                          child: const Text('Login'),
                        )),
                    Row(
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
