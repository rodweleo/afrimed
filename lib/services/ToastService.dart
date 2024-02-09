import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToastService {
  static void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        closeIconColor: Colors.redAccent,
        content: Text(message),
        duration: const Duration(seconds: 3), // Adjust the duration as needed
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  //making a success snack-bar
  static showSuccessToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white,),
            const SizedBox(
              width: 5,
            ),
            Text(message, style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.038
            ),),
          ],
        ),
        duration:
            const Duration(seconds: 3), // Adjust the duration as needed
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(8.0),
        showCloseIcon: true,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  //making an error snack-bar
  static showErrorToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.038
        ),),
        duration:
        const Duration(seconds: 3), // Adjust the duration as needed
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(8.0),
        showCloseIcon: true,
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
