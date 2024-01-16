import 'package:connecta/pages/accounts/buyer/widgets/ProfileMenuWidget.dart';
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
      appBar: AppBar(title: Text('Settings'), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              print('Show menu');
            },
            icon: Icon(Icons.more_vert))
      ]),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
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
                            icon: Icon(Icons.phone),
                            onPress: () {
                              print('Change phone number');
                            }),
                        Divider(
                          color: Colors.white,
                        ),
                        ProfileMenuWidget(
                            title: 'Change Password',
                            icon: Icon(Icons.password),
                            onPress: () {
                              print('Change phone number');
                            }),
                      ],
                    ),
                  ),
                  Column(children: [
                    ProfileMenuWidget(
                        title: 'Delete Account',
                        icon: Icon(Icons.delete_forever),
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
