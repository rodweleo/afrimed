import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String?> sendOTP(String? mobile, BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = "";

  //verifying the phone number
  try {
    await auth.verifyPhoneNumber(
        phoneNumber: mobile!,
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          // Automatically sign in the user after verification is completed
          await auth.signInWithCredential(authCredential);
          // You can return a success message or perform additional actions here
          print('User signed in successfully!');
        },
        verificationFailed: (FirebaseAuthException exception) {
          if (exception.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
            print(
                'Error during phone number verification: ${exception.message}');
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: '147852');
          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);

          verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String timeout) {
          print('Verification timeout: $timeout');
          // You can return a timeout message or perform additional actions here
        });

    return verificationId;
  } catch (e) {
    return null;
  }
}
