import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              color: Theme.of(context).colorScheme.secondary,
              size: MediaQuery.of(context).size.height * 0.2,
            ),
            Text(
              "You currently have not notifications",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: MediaQuery.of(context).size.height * 0.02),
            )
          ],
        ),
      )),
    );
  }
}
