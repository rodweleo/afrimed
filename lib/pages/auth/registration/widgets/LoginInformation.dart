import 'package:flutter/material.dart';

class LoginInformation extends StatelessWidget {
  const LoginInformation(
      {super.key,
      required this.usernameController,
      required this.passwordController,
      required this.confirmPasswordController});

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Login Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: usernameController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey)),
              labelText: 'Username',
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
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
              labelText: 'Password',
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                suffixIcon:
                    IconButton(onPressed: () {}, icon: Icon(Icons.visibility))),
          ),
        ),
      ],
    );
  }
}
