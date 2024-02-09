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
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _countyController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();


  //create a boolean to check the state of the entered information
  //if there is any change, the submit button is activated, else, the button remains disabled

  bool dataEdited = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data
    _nameController.text = widget.account.name;
    _emailController.text = widget.account.contact.email;
    _contactController.text = widget.account.contact.phoneNumber.toString();
    _countyController.text = widget.account.location.county;
    _businessNameController.text = widget.account.businessInfo.businessName;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _countyController.dispose();
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
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name'),
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
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Email')
                        ),
                        onChanged: (input){
                          _emailController.text = input;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _contactController,
                        obscureText: false,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Contact')
                        ),
                        onChanged: (input){
                          _contactController.text = input;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _countyController,
                        obscureText: false,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('County')
                        ),
                        onChanged: (input){
                          _countyController.text = input;
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _businessNameController,
                        obscureText: false,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Business Name')
                        ),
                        onChanged: (input){
                          _businessNameController.text = input;
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
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5))),
                    padding: const EdgeInsets.all(16.0),),
                  onPressed: () {
                    //edit the details of the profile

                  }, child: const Text('Save Changes'),))
          ],
        ),
      ),
    );
  }
}
