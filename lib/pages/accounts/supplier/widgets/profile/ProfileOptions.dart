import 'package:AfriMed/models/ProfileOption.dart';
import 'package:AfriMed/pages/accounts/supplier/widgets/profile/ProfileOptionCard.dart';
import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProfileOption> profileOptions = [
      ProfileOption(
        title: 'Categories',
        icon: const Icon(Icons.category_outlined),
      ),
      ProfileOption(title: 'Reviews', icon: const Icon(Icons.reviews_outlined)),
      ProfileOption(
        title: 'Revenues',
        icon: const Icon(Icons.wallet_outlined),
      ),
      ProfileOption(title: 'Offers', icon: const Icon(Icons.local_offer)),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemCount: profileOptions.length,
        itemBuilder: (BuildContext context, int index) {
          ProfileOption profileOption = profileOptions[index];
          return ProfileOptionCard(profileOption: profileOption);
        },
      ),
    );
  }
}
