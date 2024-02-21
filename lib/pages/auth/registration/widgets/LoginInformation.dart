import 'package:flutter/material.dart';

class LoginInformation extends StatefulWidget {
  const LoginInformation(
      {super.key,
      required this.usernameController,
      required this.passwordController,
      required this.confirmPasswordController});

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<LoginInformation> createState() => _LoginInformationState();
}

class _LoginInformationState extends State<LoginInformation> {
  bool visiblePassword = false;
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
            controller: widget.usernameController,
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
            controller: widget.passwordController,
            obscureText: !visiblePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      visiblePassword = !visiblePassword;
                    });
                  },
                  icon: Icon(visiblePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined)),
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
            controller: widget.confirmPasswordController,
            obscureText: !visiblePassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
                      });
                    },
                    icon: Icon(visiblePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined))),
          ),
        ),
      ],
    );
  }
}
