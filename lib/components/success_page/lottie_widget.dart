import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
          "https://assets8.lottiefiles.com/packages/lf20_jz2wa00k.json",
          repeat: false),
    );
  }
}
