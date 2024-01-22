import 'package:flutter/material.dart';

import '../../../../models/Account.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.account});
  final Account account;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data
    _nameController.text = widget.account.name ?? '';
    _emailController.text = widget.account.contact.email ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();

  }

  /*void _saveChanges() async {
    //update the user information
    try{
      await widget.account?.updateDisplayName(_nameController.text);
      //updating the display name
      await widget.user?.updateEmail(_emailController.text);
      //updating the email address

      print("User information updated successfully");
    }catch(e){
      print('Error updating user information: $e');
    }

  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
              ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (input){
                          _nameController.text = input;
                        },
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _emailController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (input){
                          _emailController.text = input;
                        },
                      ),
                    ),
                  ],
                ),

              ],

            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5))),
                    padding: const EdgeInsets.all(16.0),),
                  onPressed: () {
                    //_saveChanges();
                  }, child: const Text('Save Changes'),))
          ],
        ),
      ),
    );
  }
}
