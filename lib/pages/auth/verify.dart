import 'package:AfriMed/pages/accounts/buyer/buyer_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../../apis/AccountApi.dart';
import '../../models/Account.dart';
import '../accounts/supplier/supplier_account.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'package:AfriMed/providers/user_provider.dart';

class VerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerificationPage({super.key, required this.verificationId, required this.phoneNumber});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController controller = TextEditingController(text: "");
  String enteredOTP = '';
  bool _isVerifying = false;
  bool _isVerified = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.help))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Verify your',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.085, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Phone number',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.085, fontWeight: FontWeight.bold),
                  )
                ]
              ),
              Text('Enter your OTP code here', style: TextStyle(color: Colors.blueGrey.withOpacity(0.75))),
              const SizedBox(height: 20.0),
              Center(
                child: PinCodeTextField(
                  autofocus: true,
                  controller: controller,
                  isCupertino: false,
                  maxLength: 6,
                  hasTextBorderColor: Colors.blue,
                  pinBoxHeight: 50.0,
                  pinBoxWidth: 50.0,
                  pinBoxRadius: 10.0,
                  keyboardType: TextInputType.number,
                  onTextChanged: (value) {
                    setState(() {
                      enteredOTP = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      textStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                  onPressed: () async {
                    setState((){
                      _isVerifying = true;
                    });
                    // Perform verification logic with enteredOTP
                    FirebaseAuth auth = FirebaseAuth.instance;
                    try{
                      PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: enteredOTP);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      setState((){
                        _isVerifying = false;
                        _isVerified = true;
                      });
                      String? uId = auth.currentUser?.uid;

                      //get the role of the user from the database
                      AccountApi accountApi = AccountApi();
                      Account? account = await accountApi.fetchAccountById(uId);

                      if(account?.role != null){
                        String? role = account?.role;

                        switch(role) {
                          case "supplier":
                          // Set the user and account in the AuthProvider
                            Provider.of<UserProvider>(context, listen: false).setUser(auth.currentUser);
                            Provider.of<UserProvider>(context, listen: false).setAccount(account);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SupplierAccount(),
                              ),
                            );
                            break;

                          case "buyer":
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BuyerAccount(),
                              ),
                            );
                            break;
                          default:
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                              ),
                            );
                        }
                      }

                    
                    }catch(e){
                      rethrow;
                    }

                    // Navigate to the main section after successful verification

                  },
                  child: _isVerifying ? const CircularProgressIndicator(color: Colors.white) : const Text('Verify Phone Number'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
