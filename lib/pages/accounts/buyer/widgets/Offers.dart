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
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 4,
        initialPage: 0,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        disableCenter: true,
        autoPlay: true,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1.0,
      ),
      items: [
        "assets/images/offer1.jpg",
        "assets/images/offer2.jpg",
        "assets/images/offer1.jpg"
      ].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Cover the full width of the screen
              // Adjust spacing between images
              child: Image.asset(
                i.toString(),
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
