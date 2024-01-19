import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/Product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: CachedNetworkImage(
                  placeholder: (context, url) => const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl:
                  widget.product.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ), //FlexibleSpaceBar
              expandedHeight: 400,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 6.0, right: 6.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.product.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.height * 0.02)),
                                TextButton(
                                    onPressed: () {
                                      /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Suppliers(),
                                        ),
                                      );*/
                                    },
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: MediaQuery.of(context).size.height * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ]),
                          Text(widget.product.category)
                        ],
                      ),
                    ),
                  ))),

            SliverList(
              delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(widget.product.description, style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    decoration: TextDecoration.none
                  ), )
                ],),
              )

            ]),),


        ]
      ),
    );
  }
}
