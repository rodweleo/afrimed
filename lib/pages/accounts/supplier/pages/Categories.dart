import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Categories'), actions: [
          IconButton(
              onPressed: () {
                print('Search');
              },
              icon: const Icon(Icons.search_outlined))
        ]),
        body: const Center(child: Text('Supplier categories')));
  }
}
