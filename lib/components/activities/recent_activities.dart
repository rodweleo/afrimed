import 'package:flutter/material.dart';


class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              spreadRadius: 2.5,
              blurRadius: 7,
              offset: const Offset(0,5), // changes position of shadow
            ),
          ]
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: const Center(
        child: Text('No recent activies'),
      ),
    );
  }
}
