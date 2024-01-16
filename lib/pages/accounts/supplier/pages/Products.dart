import 'package:connecta/pages/accounts/supplier/components/ProductCard.dart';
import 'package:connecta/pages/accounts/supplier/pages/AddProduct.dart';
import 'package:connecta/pages/accounts/supplier/widgets/ProductListSkeleton.dart';
import 'package:flutter/material.dart';
import '../../../../apis/Product_Api.dart';
import '../../../../models/Product.dart';
import '../../../../providers/user_provider.dart';
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
    String sId = Provider.of<UserProvider>(context, listen: false).user!.uid;
    _supplierProducts = productApi.fetchAllSupplierProducts(sId);
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
                  print('Navigate to the notification page');
                },
                icon: Icon(Icons.notifications_active_outlined))
          ]),
      body: FutureBuilder<List<Product>>(
          future: _supplierProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductListSkeleton(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Product> _supplierProducts = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemCount: _supplierProducts.length,
                    itemBuilder: (context, index) {
                      Product product = _supplierProducts[index];
                      return ProductCard(product: product);
                    }),
              );
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductForm()),
            );
          },
          label: const Text('Add Product')),
    );
  }
}
