import 'dart:async';

import 'package:AfriMed/components/cards/platform_product_card.dart';
import 'package:AfriMed/models/Product.dart';
import 'package:AfriMed/pages/accounts/admin/pages/add_platform_product.dart';
import 'package:AfriMed/pages/accounts/admin/pages/platform_product_page.dart';
import 'package:flutter/material.dart';
import '../../../../apis/Product_Api.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  Future<List<Product>> _loadProducts() {
    Product_Api productApi = Product_Api();
    _products = productApi.fetchProducts();
    //getting the current active supplier Id
    return productApi.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Products'),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPlatformProduct()),
                  );
                },
                icon: const Icon(Icons.add_circle))
          ]),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        child: FutureBuilder(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10.0,),
                      Text('Fetching products...')
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Product> products = snapshot.data as List<Product>;
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Total products in store:', style: TextStyle(
                                fontWeight: FontWeight.w500
                            ),),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(products.length.toString(), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                fontStyle: FontStyle.italic
                            ),)
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: products.length,
                            shrinkWrap: true,

                            itemBuilder: (context, index) {
                              Product product = products[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlatformProductPage(product: product)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PlatformProductCard(product: product),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                );
              }
            }),
      ),
    );
  }
}
