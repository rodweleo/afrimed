import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../../apis/AccountApi.dart';
import '../../models/Account.dart';

class VerifyAccount extends StatefulWidget {
  final String verificationId;
  final Account account;

  const VerifyAccount({super.key, required this.verificationId, required this.account});

  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  TextEditingController controller = TextEditingController(text: "");
  String enteredOTP = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Phone Number Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/OTPVerification.json',
                  height: 300, width: 300),
              const SizedBox(height: 20.0),
              Text(
                'Enter OTP sent to ${widget.account.contact.phoneNumber}',
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              PinCodeTextField(
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
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    textStyle: const TextStyle(
                        color: Colors.white, fontStyle: FontStyle.normal)),
                onPressed: () async {
                  // Perform verification logic with enteredOTP
                  FirebaseAuth auth = FirebaseAuth.instance;
                  try {
                    PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: enteredOTP);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);

                    //once the account has been created, get the user id
                    String? uId = auth.currentUser?.uid;

                    //save the account under the document id uId above
                    AccountApi accountApi = AccountApi();
                    String? feedBack = await accountApi.createAccount(
                        uId, widget.account);

                    if (feedBack != null) {
                      //change the status of onboarding to false
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          feedBack,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        closeIconColor: Colors.red.withOpacity(0.4),
                        backgroundColor: Colors.green,
                      ));
                      /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyerAccount(),
                      ),
                    );*/
                    }
                                    }catch(e){
                    rethrow;
                  }

                },
                child: const Text('Verify Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
