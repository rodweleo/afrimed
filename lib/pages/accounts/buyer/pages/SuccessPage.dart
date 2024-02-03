import 'package:AfriMed/pages/accounts/buyer/buyer_account.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Lottie.asset('assets/images/LottieSuccess.json',
                    fit: BoxFit.fill),
                const Text('Operation done successfully!',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        color: Colors.black)),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.black, // background (button) color
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5))), // foreground (text) color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BuyerAccount(),
                        ),
                      );
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
