import 'package:connecta/models/ProfileOption.dart';
import 'package:connecta/pages/accounts/supplier/SupplierAccount.dart';
import 'package:connecta/pages/accounts/supplier/pages/Categories.dart';
import 'package:connecta/pages/accounts/supplier/pages/Offers.dart';
import 'package:connecta/pages/accounts/supplier/pages/Reviews.dart';
import 'package:flutter/material.dart';

class ProfileOptionCard extends StatefulWidget {
  final ProfileOption profileOption;
  const ProfileOptionCard({super.key, required this.profileOption});

  @override
  State<ProfileOptionCard> createState() => _ProfileOptionCardState();
}

class _ProfileOptionCardState extends State<ProfileOptionCard> {
  void navigateToOptionPage(ProfileOption profileOption) {
    switch (profileOption.title) {
      case 'Categories':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Categories()),
        );
        break;
      case 'Reviews':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Reviews()),
        );
        break;
      case 'Offers':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Offers()),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupplierAccount()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      child: GestureDetector(
        onTap: () {
          navigateToOptionPage(widget.profileOption);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.profileOption.icon,
                  Text(widget.profileOption.title)
                ]),
          ),
        ),
      ),
    );
  }
}
