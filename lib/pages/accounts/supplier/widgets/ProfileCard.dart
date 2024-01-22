import 'package:AfriMed/models/Account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/UserProfilePage.dart';

class ProfileCard extends StatelessWidget {
  final Account? account;
  const ProfileCard({super.key, required this.account});


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5)),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: user?.photoURL != null ? CircleAvatar(
              radius: 20, backgroundImage: NetworkImage(user!.photoURL!))
              : const CircleAvatar(
              radius: 20, child: Icon(Icons.person),),
          title: Text(account!.name),
          subtitle: Text(account!.contact.phoneNumber.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(account: account),
              ),
            );
          },
        ),
      ),
    );
  }
}
