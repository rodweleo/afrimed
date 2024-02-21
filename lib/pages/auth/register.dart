import 'package:AfriMed/pages/auth/login.dart';
import 'package:AfriMed/pages/auth/registration/widgets/BusinessInformation.dart';
import 'package:AfriMed/pages/auth/registration/widgets/LoginInformation.dart';
import 'package:AfriMed/pages/auth/registration/widgets/PersonalInformation.dart';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  //create the controllers
  final TextEditingController nameController = TextEditingController();
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

  bool hasAgreedTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    final screens = [
      PersonalInformation(
          nameController: nameController,
          emailController: emailController,
          contactController: contactController),
      BusinessInformation(
          businessNameController: businessNameController,
          addressController: addressController,
          townController: townController,
          countyController: countyController),
      LoginInformation(
          usernameController: usernameController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: registrationFormKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text('Fill in the details below.'),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 15,
              ),

              //some space between email and mobile
              const SizedBox(
                height: 15,
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
                    ? () {
                        //register the user
                        if (registrationFormKey.currentState!.validate()) {
                          //proceed to submitting the information
                        }
                      }
                    : null,
                child: const Text(
                  'Submit',
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
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
