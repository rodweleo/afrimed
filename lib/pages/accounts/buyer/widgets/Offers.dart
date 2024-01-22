import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          'assets/images/offer1.jpg',
          'assets/images/offer2.jpg',
          'assets/images/offer1.jpg',
        ]
            .map((item) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(item.toString(), fit: BoxFit.fill),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            disableCenter: false,
            viewportFraction: 1.0));
  }
}
