import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key,
    required this.title,
    required this.content,
    required this.boxShadowColor,
    required this.endIconBackground,
    required this.endIcon,
    this.textColor,});

  final String title;
  final String content;
  final Color boxShadowColor;
  final Color endIconBackground;
  final Icon endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            spreadRadius: 1,
            blurRadius: 2
          )
        ]
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04),),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(content, style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05
                )),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: endIconBackground),
                  child: endIcon,
                )
              ],
            )
          ]),
    );
  }
}
