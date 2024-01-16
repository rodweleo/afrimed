import 'package:connecta/models/Account.dart';
import 'package:flutter/material.dart';

import '../../../../apis/Product_Api.dart';
import '../../../../components/cards/ProductCard.dart';
import '../../../../models/Product.dart';

class SupplierPage extends StatefulWidget {
  final Account? account;
  const SupplierPage({super.key, required this.account});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  final TextEditingController _searchBoxController = TextEditingController();
  var searchQuery = "";

  @override
  void initState() {

    super.initState();
  }

  Future<List<Product>> _loadSupplierProducts() async {
    Product_Api productApi = Product_Api();

    // Getting the current active supplier Id
    List<Product> allProducts =
    await productApi.fetchAllSupplierProducts(widget.account!.id!);

    // Filter products based on the search query
    List<Product> filteredProducts = allProducts
        .where((product) =>
        product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            snap: false,
            pinned: true,
            floating: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(color: Colors.blueGrey),
                child: widget.account?.imageUrl != ""
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.account!.imageUrl))
                    : Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.height * 0.075,
                      ),
              ),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.account!.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(widget
                                  .account!.businessInfo.businessCategory),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    widget.account!.contact.phoneNumber
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                Text(widget.account!.contact.email,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ]),
                        ]),
                  ),
                )),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child:  SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _searchBoxController,
                            onChanged: (String? value){
                              setState(() {
                                searchQuery = _searchBoxController.text;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Search product...',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10), // Optional padding
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      ),
                    IconButton(onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Sort products by:'),
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Text('Alphabets (A-Z)'),
                                Text('Date of Expiration'),
                              ]
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Dismiss the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontStyle: FontStyle.normal)),
                                onPressed: () {
                                  print('Sorting');
                                },
                                child: const Text('Sort'),
                              ),
                            ],
                          );
                        },
                      );
                    }, icon: const Icon(Icons.sort),
                  )]),
                  FutureBuilder<List<Product>>(
                      future: _loadSupplierProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<Product> supplierProducts = snapshot.data!;
                          return Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Set the number of columns here
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: supplierProducts.length,
                              itemBuilder: (context, index) {
                                Product product = supplierProducts[index];
                                return ProductCard(product: product);
                              },
                            ),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
