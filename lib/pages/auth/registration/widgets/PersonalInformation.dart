import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.contactController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController contactController;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Personal Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: nameController,
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
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
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
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: contactController,
            keyboardType: TextInputType.phone,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contact',
            ),
          ),
        ),
      ],
    );
  }
}
