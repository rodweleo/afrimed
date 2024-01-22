import 'package:flutter/material.dart';

import '../../pages/accounts/buyer/widgets/Offers.dart';
import '../../pages/accounts/buyer/widgets/ProfileMenuWidget.dart';
import '../../pages/accounts/supplier/pages/Reviews.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: const Offset(1, 1))
          ]),
      child: Column(
        children: [
          ProfileMenuWidget(
              title: "Notifications",
              icon: const Icon(Icons.notifications_active_outlined),
              textColor: Colors.black.withOpacity(0.8),
              endIcon: false,
              onPress: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Reviews()),
                );
              }),

          const Divider(),
          ProfileMenuWidget(
              title: "Reviews",
              icon: const Icon(Icons.reviews_outlined),
              textColor: Colors.black.withOpacity(0.8),
              endIcon: false,
              onPress: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Reviews()),
                );
              }),
          const Divider(),
          ProfileMenuWidget(
              title: "Offers",
              icon: const Icon(Icons.local_offer),
              textColor: Colors.black.withOpacity(0.8),
              endIcon: false,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Offers()),
                );
              }),
        ],
      ),
    );
  }
}
