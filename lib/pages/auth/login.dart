import 'package:AfriMed/apis/AccountApi.dart';
import 'package:AfriMed/pages/accounts/buyer/buyer_account.dart';
import 'package:AfriMed/pages/accounts/supplier/supplier_account.dart';
import 'package:AfriMed/pages/auth/register.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:AfriMed/services/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Account.dart';
import '../accounts/admin/admin_account.dart';

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
      appBar: AppBar(
        title: Text(
          'AfriMed',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.04,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    TextFormField(
                      controller: _usernameController,
                      obscureText: false,
                      onChanged: (value) {
                        setState(() {
                          _usernameController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                          disabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: BorderSide(
                                color: _usernameController.text.isNotEmpty
                                    ? Colors.green
                                    : Colors.grey,
                                width: 2.0),
                          ),
                          prefixIcon: Icon(Icons.person,
                              color: _usernameController.text.isNotEmpty
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.secondary),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              color: _usernameController.text.isNotEmpty
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.secondary),
                          suffixIcon: _usernameController.text.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : null),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _passwordController.text = value;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: BorderSide(
                                color: _passwordController.text.isNotEmpty
                                    ? Colors.green
                                    : Colors.grey,
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _passwordController.text.isNotEmpty
                                      ? Colors.green
                                      : Colors.grey)),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: _passwordController.text.isNotEmpty
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.secondary),
                          prefixIcon: Icon(Icons.vpn_key_rounded,
                              color: _passwordController.text.isNotEmpty
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.secondary),
                          suffixIcon: _passwordController.text.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              : null),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
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
                              // If the form is valid, display a snack-bar.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );

                              //login with username and password
                              AccountApi accountApi = AccountApi();
                              try{
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

                                    case 'admin':
                                    //set the auth provider to contain the details of the current account
                                      Provider.of<AuthProvider>(context,
                                          listen: false)
                                          .setLoggedInAccount(account);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AdminAccount()),
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
                                }else{
                                  ToastService.showErrorToast(context, 'Matching account details not found.');
                                }
                              }catch(e){
                                ToastService.showErrorToast(context, 'Something went wrong. Try again.');
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
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
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
