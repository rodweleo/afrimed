import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/supplier_product_page.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/add_supplier_product.dart';
import 'package:AfriMed/pages/accounts/supplier/widgets/cards/supplierProductCard.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import '../../../../apis/Product_Api.dart';
import 'package:provider/provider.dart';

class SupplierProductsPage extends StatefulWidget {
  const SupplierProductsPage({super.key});

  @override
  State<SupplierProductsPage> createState() => _SupplierProductsPageState();
}

class _SupplierProductsPageState extends State<SupplierProductsPage> {
  late Future<List<SupplierProduct>> _supplierProducts;

  @override
  void initState() {
    _loadSupplierProducts();
    super.initState();
  }

  void _loadSupplierProducts() {
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
                    MaterialPageRoute(builder: (context) => const AddProduct()),
                  );
                },
                icon: const Icon(Icons.add_circle))
          ]),
      body: FutureBuilder<List<SupplierProduct>>(
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
              List<SupplierProduct> supplierProducts = snapshot.data!;
              return Scrollbar(
                  trackVisibility: true,
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: supplierProducts.length,
                      itemBuilder: (context, index) {
                        SupplierProduct product = supplierProducts[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SupplierProductPage(product: product)),
                            );
                          },
                            child: SupplierProductCard(product: product)
                        );
                      }),
                ),
              );
            }
          }),
    );
  }
}
