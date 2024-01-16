import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Offers'), actions: [
          IconButton(
              onPressed: () {
                print('Search');
              },
              icon: Icon(Icons.search_outlined))
        ]),
        body: Center(child: Text('Offers')));
  }
}
