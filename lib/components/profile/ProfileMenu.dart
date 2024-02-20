import 'package:AfriMed/pages/accounts/supplier/pages/notifications.dart';
import 'package:flutter/material.dart';
import '../../pages/accounts/buyer/widgets/Offers.dart';
import '../../pages/accounts/buyer/widgets/ProfileMenuWidget.dart';
import '../../pages/accounts/supplier/pages/reviews_page.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuWidget(
            title: "Notifications",
            icon: const Icon(Icons.notifications_active_outlined),
            textColor: Colors.black.withOpacity(0.8),
            endIcon: false,
            onPress: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()),
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
                MaterialPageRoute(builder: (context) => const Reviews()),
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
                MaterialPageRoute(builder: (context) => const Offers()),
              );
            }),
      ],
    );
  }
}
