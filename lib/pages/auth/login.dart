import 'package:connecta/pages/accounts/buyer/pages/BuyerRegistration.dart';
import 'package:connecta/pages/accounts/supplier/pages/SupplierRegistration.dart';
import 'package:connecta/pages/auth/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber? _phoneNumber;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AfriMed'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InternationalPhoneNumberInput(
                        maxLength: 11,
                        onInputChanged: (PhoneNumber number) {
                          _phoneNumber = number;
                        },
                        inputDecoration: const InputDecoration(
                          fillColor: Colors.blue,
                          labelText: 'Phone Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              FirebaseAuth auth = FirebaseAuth.instance;
                              // Perform login or verification logic with _phoneNumber
                              try {
                                await auth.verifyPhoneNumber(
                                    phoneNumber: _phoneNumber?.phoneNumber,
                                    verificationCompleted: (PhoneAuthCredential
                                        authCredential) async {
                                      // Automatically sign in the user after verification is completed
                                      await auth
                                          .signInWithCredential(authCredential);
                                      // You can return a success message or perform additional actions here
                                      //print('User signed in successfully!');
                                    },
                                    verificationFailed:
                                        (FirebaseAuthException exception) {
                                      if (exception.code ==
                                          'invalid-phone-number') {
                                        print(
                                            'The provided phone number is not valid.');
                                      } else {
                                        print(
                                            'Error during phone number verification: ${exception.message}');
                                      }
                                    },
                                    codeSent: (String verificationId,
                                        int? forceResendingToken) {
                                      setState((){
                                        _isLoading = false;
                                      });
                                      // Create a PhoneAuthCredential with the code
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => VerificationPage(verificationId: verificationId, phoneNumber: _phoneNumber!.phoneNumber!,)),
                                      );

                                    },
                                    codeAutoRetrievalTimeout: (String timeout) {
                                      // You can return a timeout message or perform additional actions here
                                    });
                              } catch (e) {
                                rethrow;
                              }

                              /* Navigate to the verification page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerificationPage(
                                    phoneNumber: _phoneNumber!.parseNumber(),
                                  ),
                                ),
                              );*/
                            }
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Login'),
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                              );*/
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('Account Options'),
                                          ListTile(
                                            title: const Text('Register as Buyer'),
                                            onTap: () {
                                              // Handle the action when "Buyer" is selected
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BuyerRegistration()),
                                              ); // Close the bottom sheet
                                              // Add your logic for continuing registration as a buyer
                                            },
                                          ),
                                          const Divider(),
                                          ListTile(
                                            title: const Text('Register as Supplier'),
                                            onTap: () {
                                              // Handle the action when "Supplier" is selected
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SupplierRegistration()),
                                              ); // Close the bottom sheet
                                              // Add your logic for continuing registration as a supplier
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
