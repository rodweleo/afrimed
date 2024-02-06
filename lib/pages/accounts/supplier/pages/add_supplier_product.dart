import 'package:AfriMed/apis/Product_Api.dart';
import 'package:AfriMed/pages/accounts/supplier/pages/confirm_add_product.dart';
import 'package:flutter/material.dart';
import '../../../../components/cards/platform_product_card.dart';
import '../../../../models/Product.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final Product_Api productApi = Product_Api();

  TextEditingController searchController = TextEditingController();

  Future<List<Product?>> _loadProducts() async {
    Product_Api productApi = Product_Api();

    // Getting the current active supplier Id
    List<Product?> allProducts =
    await productApi.fetchProducts();

    // Filter products based on the search query
    List<Product?> filteredProducts = allProducts
        .where((product) =>
        (product!.name.toLowerCase() + product.description.toLowerCase() + product.category.toLowerCase()).contains(searchController.text.toLowerCase()))
        .toList();

    return filteredProducts;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState((){
                  searchController.text = value;
                });
              },
              keyboardType: TextInputType.text,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Search product...',
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Colors.black)),
                suffixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5),)
              ),
              obscureText: false,
            ),
            FutureBuilder<List<Product?>>(
                future: _loadProducts(),
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
                    List<Product?> products = snapshot.data!;
                    return searchController.text == "" ? const Text('') : Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Set the number of columns here
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          Product? product = products[index];
                          return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmAddProduct(
                                      product: product!,
                                    ),
                                  ),
                                );
                              },
                              child: PlatformProductCard(product: product)
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        )
      ),
    );
  }
}
