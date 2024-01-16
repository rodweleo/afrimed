import 'package:flutter/material.dart';

class RouterText extends StatelessWidget {
  const RouterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50, bottom: 50),

      /// 8.0-8.0
      child: Text("Successfully completed!",
          style: TextStyle(color: Colors.black, fontSize: 20)),

      /// 25
    );
  }
}
