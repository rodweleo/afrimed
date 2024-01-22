import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/Account.dart';
import '../../pages/accounts/buyer/pages/EditProfile.dart';


class ProfileInformation extends StatelessWidget {
  ProfileInformation({super.key, required this.account});
  Account? account;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.5),
              child: account!.imageUrl == "" ? Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade500.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ) : CachedNetworkImage(
                placeholder: (context, url) => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 50,
                width: 50,
                imageUrl:
                account!.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 7,
              right: 7,
              child: Center(
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueGrey),
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfile(account: account!)),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                    )
                ),
              ),
            ),
          ],
        ),
        Text(account != null ? account!.name.toString() : '',
            style: const TextStyle(
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        Text(account != null ? account!.contact.email.toString() : '',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              letterSpacing: 1.5,
            )),
      ],
    );
  }
}
