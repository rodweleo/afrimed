import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  Status({super.key, required this.status});
  String status;

  @override
  Widget build(BuildContext context) {
    // Define colors based on the completed status
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'COMPLETED':
        backgroundColor = Colors.lightGreen.shade200;
        textColor = Colors.green;
        break;
      case 'IN PROGRESS':
        backgroundColor = const Color(0xFFFFE0B2);
        textColor = Colors.orange;
        break;
      case 'NOT COMPLETED':
        backgroundColor = Colors.black.withOpacity(0.2);
        textColor = Colors.black;
        break;
      case 'CANCELLED':
        backgroundColor = const Color(0xFFFFCDD2);
        textColor = Colors.red;
        break;
      case 'true':
        backgroundColor = Colors.lightGreen.shade200;
        textColor = Colors.green;
        break;
      case 'false':
        backgroundColor = const Color(0xFFFFCDD2);
        textColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey.shade400;
        textColor = Colors.black;
    }
    return Container(
      padding:
      const EdgeInsets.only(top: 2.0, right: 8.0, bottom: 2.0, left: 8.0),
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: textColor,
          ),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(status,
          style:
          TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }
}
