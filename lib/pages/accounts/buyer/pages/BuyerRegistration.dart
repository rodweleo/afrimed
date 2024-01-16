import 'dart:io';
import 'package:connecta/pages/accounts/buyer/BuyerAccount.dart';
import 'package:connecta/pages/auth/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class BuyerRegistration extends StatefulWidget {
  const BuyerRegistration({super.key});

  @override
  State<BuyerRegistration> createState() => _BuyerRegistrationState();
}

class _BuyerRegistrationState extends State<BuyerRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //create the controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String vendorType = "";
  String selectedOption = "";
  bool hasAgreedTermsAndConditions = false;

  FilePickerResult? documents;
  File? selectedDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registeration'),
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
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'Business',
                        groupValue: vendorType,
                        onChanged: (value) {
                          setState(() {
                            vendorType = "Business";
                          });
                        },
                      ),
                      Text('Business')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Individual',
                        groupValue: vendorType,
                        onChanged: (value) {
                          setState(() {
                            vendorType = "Individual";
                          });
                        },
                      ),
                      Text('Individual')
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _nameController,
                  obscureText: false,
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
              if (vendorType == 'Business')
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _emailController,
                    obscureText: false,
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
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _emailController,
                  obscureText: false,
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
                child: TextField(
                  controller: _contactController,
                  obscureText: false,
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
                width: 250,
                child: TextField(
                  controller: _addressController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Do you have relevant valid certificates and licenses?'),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Yes',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = "Yes";
                              });
                            },
                          ),
                          Text('Yes')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'I will upload later',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = "I will upload later";
                              });
                            },
                          ),
                          Text('I will upload later')
                        ],
                      ),
                    ],
                  )
                ],
              ),
              if (selectedOption == 'Yes')
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
                            ;
                          });
                        }
                      },
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.all(8.0),
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
                            Icon(Icons.file_upload, color: Colors.blueGrey)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    value: this.hasAgreedTermsAndConditions,
                    onChanged: (bool? value) {
                      setState(() {
                        this.hasAgreedTermsAndConditions = value ?? false;
                        ;
                      });
                    },
                  ),
                  Text('I agree with Terms and Policies of Konnecta.')
                ],
              ),
              //create button for register
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // background (button) color
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5))), // foreground (text) color
                ),
                onPressed: () {
                  //we will trying to print input
                  //print(_nameController.text);
                  //print(_emailController.text);
                  //print(_contactController.text);
                  //print(_addressController.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuyerAccount()),
                  );
                },
                child: const Text(
                  'Register',
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
                        MaterialPageRoute(builder: (context) => LoginPage()),
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
