import 'package:AfriMed/pages/accounts/supplier/components/ProductCard.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/AddProduct.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/Product.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import '../../../../apis/Product_Api.dart';
import '../../../../models/Product.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Product>> _supplierProducts;

  @override
  void initState() {
    _loadSupplierProducts();
    super.initState();
  }

  void _loadSupplierProducts() async {
    Product_Api productApi = Product_Api();
    //getting the current active supplier Id
    _supplierProducts = productApi.fetchAllSupplierProducts(Provider.of<AuthProvider>(context, listen: false).getCurrentAccount()!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Products'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductForm()),
                  );
                },
                icon: const Icon(Icons.add_circle))
          ]),
      body: FutureBuilder<List<Product>>(
          future: _supplierProducts,
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
              List<Product> supplierProducts = snapshot.data!;
              return Scrollbar(
                  trackVisibility: true,
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: supplierProducts.length,
                      itemBuilder: (context, index) {
                        Product product = supplierProducts[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductPage(product: product)),
                            );
                          },
                            child: ProductCard(product: product)
                        );
                      }),
                ),
              );
            }
          }),
    );
  }
}
