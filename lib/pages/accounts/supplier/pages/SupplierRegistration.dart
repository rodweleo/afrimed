import 'dart:io';
import 'package:connecta/pages/auth/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/Account.dart';
import '../../../auth/VerifyAccount.dart';


class SupplierRegistration extends StatefulWidget {
  const SupplierRegistration({super.key});

  @override
  State<SupplierRegistration> createState() => _SupplierRegistrationState();
}

class _SupplierRegistrationState extends State<SupplierRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _businessCategories = [
    'Pharmaceutical Products',
    'Non-Pharmaceutical Products'
  ];

  //create the controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  String _businessCategory = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool hasUploadedIdentificationDocuments = false;
  bool hasAgreedTermsAndConditions = false;
  FilePickerResult? documents;
  File? selectedDocument;
  bool isOnboarding = false;

  @override
  void initState() {
    super.initState();
    _businessCategory = _businessCategories[0];
  }

  void _handleOnboarding() async {
    setState(() {
      isOnboarding = true;
    });

    //create a new supplier
      Account newAccount = Account(
        id: "",
        name: _nameController.text,
        businessInfo: BusinessInfo(
            businessCategory: _businessCategory,
            businessName: _businessNameController.text),
        contact: Contact(
          email: _emailController.text,
          phoneNumber: int.parse(_contactController.text),
        ),
        location: Location(
            county: _countyController.text,
            town: _townController.text,
            address: _addressController.text),
        role: "supplier",
        hasUploadedIdentificationDocuments: hasUploadedIdentificationDocuments,
        isVerified: false,
        imageUrl: "",
      );

      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: '+${_contactController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          // The user is signed in automatically, and you can access the user's information using _auth.currentUser.

          // Link the phone authentication to the existing user account
          await auth.currentUser?.linkWithCredential(credential);

        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure if needed.
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            isOnboarding = false;
          });
          // Handle code sent to the user's phone.
          // Prompt the user to enter the code.
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyAccount(
                      verificationId: verificationId,
                      account: newAccount,
                    )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout. Handle the situation if needed.
        },
      );

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Onboarding'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Fill in the details below.'),
              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _nameController,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    labelText: 'Name',
                  ),
                ),
              ),
              //some space between name and email
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _businessNameController,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the business';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Business Name',
                  ),
                ),
              ),
              //some space between name and email
              const SizedBox(
                height: 15,
              ),
              InputDecorator(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(12, 10, 20, 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "poppins",
                    ),
                    hint: const Text(
                      "Select Business Category",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    value: _businessCategory,
                    items: _businessCategories
                        .map<DropdownMenuItem<String>>(
                          (category) => DropdownMenuItem(
                            value: category.capitalize,
                            child: Text(category.toString()),
                          ),
                        )
                        .toList(),
                    isExpanded: true,
                    isDense: true,
                    onChanged: (String? value) => setState(
                      () {
                        if (value != null) _businessCategory = value;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
              ),
              //some space between email and mobile
              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact information';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contact',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3.0,
                children: [
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: _countyController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your county';
                        }
                        return null; // Return null if the input is valid
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'County',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: _townController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your town';
                        }
                        return null; // Return null if the input is valid
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Town',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: TextFormField(
                      controller: _addressController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null; // Return null if the input is valid
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                ],
              ),
            ),
              const SizedBox(
                height: 15,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Do you have relevant valid certificates and licenses?'),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Yes',
                            groupValue: hasUploadedIdentificationDocuments,
                            onChanged: (value) {
                              setState(() {
                                hasUploadedIdentificationDocuments = true;
                              });
                            },
                          ),
                          const Text('Yes')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'I will upload later',
                            groupValue: hasUploadedIdentificationDocuments,
                            onChanged: (value) {
                              setState(() {
                                hasUploadedIdentificationDocuments = false;
                              });
                            },
                          ),
                          const Text('I will upload later')
                        ],
                      ),
                    ],
                  )
                ],
              ),
              if (hasUploadedIdentificationDocuments)
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        documents = await FilePicker.platform
                            .pickFiles(allowMultiple: true);

                        // Check if files were picked
                        if (documents?.files.isNotEmpty ?? false) {
                          // Display the first selected file
                          final file = documents!.files.first;
                          setState(() {
                            // Set the selected file to a variable to be used in the UI
                            selectedDocument =
                                file.path != null ? File(file.path!) : null;
                          });
                        }
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upload Documents',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            const Icon(Icons.file_upload, color: Colors.blueGrey)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (selectedDocument != null)
                      Row(
                        children: [
                          Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 2.5),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Image.file(selectedDocument!)),
                        ],
                      ),
                  ],
                ),
              Row(
                children: [
                  Checkbox(
                    value: hasAgreedTermsAndConditions,
                    onChanged: (bool? value) {
                      setState(() {
                        hasAgreedTermsAndConditions = value ?? false;
                      });
                    },
                  ),
                  const Text('I agree with Terms and Policies of Konnecta.')
                ],
              ),
              //create button for register
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey, // background (button) color
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5))), // foreground (text) color
                ),
                onPressed: hasAgreedTermsAndConditions
                    ? () async {
                        _handleOnboarding();
                      }
                    : null,
                child: isOnboarding
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ),
              Row(
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ), // Text displayed on the button
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
