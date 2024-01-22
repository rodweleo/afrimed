import 'package:AfriMed/pages/accounts/buyer/widgets/ProfileMenuWidget.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              print('Show menu');
            },
            icon: const Icon(Icons.more_vert))
      ]),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.blueGrey.withOpacity(0.2),
                    child: Column(
                      children: [
                        ProfileMenuWidget(
                            title: 'Change Phone Number',
                            icon: const Icon(Icons.phone),
                            onPress: () {
                              print('Change phone number');
                            }),
                        const Divider(
                          color: Colors.white,
                        ),
                        ProfileMenuWidget(
                            title: 'Change Password',
                            icon: const Icon(Icons.password),
                            onPress: () {
                              print('Change phone number');
                            }),
                      ],
                    ),
                  ),
                  Column(children: [
                    ProfileMenuWidget(
                        title: 'Delete Account',
                        icon: const Icon(Icons.delete_forever),
                        onPress: () {
                          print('Delete Account');
                        }),
                  ]),
                ]),
          )
        ]),
      ),
    );
  }
}
