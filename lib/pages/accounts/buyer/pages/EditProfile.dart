import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final User? user;
  EditProfile({super.key, this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    // Initialize controllers with user data
    _nameController.text = widget.user?.displayName ?? '';
    _emailController.text = widget.user?.email ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();

  }

  void _saveChanges() async {
    //update the user information
    try{
      await widget.user?.updateDisplayName(_nameController.text);
      //updating the display name
      await widget.user?.updateEmail(_emailController.text);
      //updating the email address

      print("User information updated successfully");
    }catch(e){
      print('Error updating user information: ${e}');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          margin: EdgeInsets.only(top:20),
          child: SingleChildScrollView(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (input){
                      _nameController.text = input;
                    },
                    obscureText: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _emailController,
                                  obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (input){
                      _emailController.text = input;
                    },
                  ),
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
                    padding: EdgeInsets.all(16.0),),
                  onPressed: () {
                    _saveChanges();
                  }, child: Text('Save Changes'),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
