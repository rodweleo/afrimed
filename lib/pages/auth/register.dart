import 'package:AfriMed/apis/AccountApi.dart';
import 'package:AfriMed/models/Account.dart';
import 'package:AfriMed/pages/auth/login.dart';
import 'package:AfriMed/pages/auth/registration/widgets/BusinessInformation.dart';
import 'package:AfriMed/pages/auth/registration/widgets/LoginInformation.dart';
import 'package:AfriMed/pages/auth/registration/widgets/PersonalInformation.dart';
import 'package:AfriMed/services/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  //create the controllers
  TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedOption = "";
  bool isCreatingAccount = false;

  //file picker for the national id
  FilePickerResult? nationalIds;

  File? selectedNationalIdDocuments;

  //file picker for the pharmaceutical documents
  FilePickerResult? pharmaceuticalDocuments;

  File? selectedPharmaceuticalDocument;

  bool hasAgreedTermsAndConditions = false;

  String accountType = "";

  void clearForm() {
    nameController.clear();
    emailController.clear();
    contactController.clear();
    businessNameController.clear();
    addressController.clear();
    townController.clear();
    countyController.clear();
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void initState() {
    super.initState();

    accountType = "Buyer";
  }

  @override
  Widget build(BuildContext context) {
    //function for creating the account
    AccountApi accountApi = AccountApi();
    Future<String?> uploadData() async {
      setState(() {
        isCreatingAccount = true;
      });
      //collecting the information for the account
      Account newAccount = Account(
        id: "",
        name: nameController.text,
        role: accountType,
        contact: Contact(
            email: emailController.text, phoneNumber: contactController.text),
        username: usernameController.text,
        hasUploadedIdentificationDocuments: false,
        password: passwordController.text,
        isVerified: false,
        imageUrl: '',
        businessName: businessNameController.text,
        location: Location(
            address: addressController.text,
            town: townController.text,
            county: countyController.text),
      );

      String? feedback = await accountApi.createAccount(newAccount);
      return feedback;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: Text(
            "Fill in the details below.",
            textAlign: TextAlign.start,
          ),
        ),
      ),
      body: Form(
        key: registrationFormKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              PersonalInformation(
                  nameController: nameController,
                  emailController: emailController,
                  contactController: contactController),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Choose account type:'),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Buyer',
                            groupValue: accountType,
                            onChanged: (value) {
                              setState(() {
                                accountType = value.toString();
                              });
                            },
                          ),
                          const Text('Buyer')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Supplier',
                            groupValue: accountType,
                            onChanged: (value) {
                              setState(() {
                                accountType = value.toString();
                              });
                            },
                          ),
                          const Text('Supplier')
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              BusinessInformation(
                  businessNameController: businessNameController,
                  addressController: addressController,
                  townController: townController,
                  countyController: countyController),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Business Documentation",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Do you have your identification documents?'),
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
                              const Text('Yes')
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
                              const Text('I will upload later')
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  if (selectedOption == 'Yes')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("National Id"),
                        GestureDetector(
                          onTap: () async {
                            nationalIds = await FilePicker.platform
                                .pickFiles(allowMultiple: true);

                            // Check if files were picked
                            if (nationalIds?.files.isNotEmpty ?? false) {
                              // Display the first selected file
                              final file = nationalIds!.files.first;
                              setState(() {
                                // Set the selected file to a variable to be used in the UI
                                selectedNationalIdDocuments =
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
                                  'Upload Document',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                                const Icon(Icons.file_upload,
                                    color: Colors.blueGrey)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (selectedNationalIdDocuments != null)
                          Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1),
                              ),
                              child: Image.file(
                                selectedNationalIdDocuments!,
                                fit: BoxFit.fill,
                              )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Pharmaceutical Licence"),
                        GestureDetector(
                          onTap: () async {
                            pharmaceuticalDocuments = await FilePicker.platform
                                .pickFiles(allowMultiple: true);

                            // Check if files were picked
                            if (pharmaceuticalDocuments?.files.isNotEmpty ??
                                false) {
                              // Display the first selected file
                              final file = pharmaceuticalDocuments!.files.first;
                              setState(() {
                                // Set the selected file to a variable to be used in the UI
                                selectedPharmaceuticalDocument =
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
                                  'Upload Document',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                                const Icon(Icons.file_upload,
                                    color: Colors.blueGrey)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (selectedPharmaceuticalDocument != null)
                          Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Image.file(
                                selectedPharmaceuticalDocument!,
                                fit: BoxFit.fill,
                              )),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              LoginInformation(
                  usernameController: usernameController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController),
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
                  const Text('I agree with Terms and Policies of AfriMed.')
                ],
              ),
              //create button for register
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // background (button) color
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5))), // foreground (text) color
                ),
                onPressed: hasAgreedTermsAndConditions
                    ? () async {
                        if (registrationFormKey.currentState!.validate()) {
                          setState(() {
                            isCreatingAccount = false;
                          });
                          //register the user
                          String? feedback = await uploadData();
                          if (feedback != null) {
                            setState(() {
                              isCreatingAccount = false;
                              clearForm();
                            });
                            ToastService.showSuccessToast(context, feedback);
                            registrationFormKey.currentState!.activate();
                          } else {
                            setState(() {
                              isCreatingAccount = false;
                            });
                          }
                        }
                      }
                    : null,
                child: isCreatingAccount
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                        ), // Text displayed on the button
                      ),
                    ],
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
