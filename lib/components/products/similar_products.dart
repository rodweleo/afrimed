import 'package:AfriMed/models/Product.dart';
import 'package:flutter/material.dart';

class SimilarProducts extends StatefulWidget {
  const SimilarProducts({super.key, required this.product});

  final Product product;

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  late Future<Product> _similarProducts;

  void _fetchSimilarProducts() async {

  }
  @override
  void initState(){
    //fetch similar products in the product's category
    _fetchSimilarProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) => CircleAvatar(
          radius: 10,
          backgroundImage: NetworkImage(
              widget.product.imageUrl!)),
    );
  }
}
