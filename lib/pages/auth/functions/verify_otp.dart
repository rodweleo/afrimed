import 'package:firebase_auth/firebase_auth.dart';

Future<String> verifyOTP(String verificationId, String code) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    // Create a PhoneAuthCredential with the entered OTP
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId:
          verificationId, // Retrieve this from the codeSent callback
      smsCode: code,
    );

    await auth.signInWithCredential(credential);

    return 'OTP verification successful!';
  } catch (e) {
    return 'Error during OTP verification: $e';
  }
}
