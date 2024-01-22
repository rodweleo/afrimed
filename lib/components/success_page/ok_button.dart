import 'package:AfriMed/pages/accounts/buyer/pages/homepage.dart';
import 'package:flutter/material.dart';

class OkButton extends StatefulWidget {
  const OkButton({super.key});

  @override
  _OkButtonState createState() => _OkButtonState();
}

class _OkButtonState extends State<OkButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Homepage()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(30)),
          child: const Center(
              child: Text("OK",
                  style: TextStyle(
                    color: Colors.white,
                  ))

              /// 18
              ),
        ));
  }
}
