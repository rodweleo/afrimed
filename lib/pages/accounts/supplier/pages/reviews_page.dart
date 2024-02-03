import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Reviews'), actions: [
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.search_outlined))
        ]),
        body: const Center(child: Text('Supplier Reviews')));
  }
}
