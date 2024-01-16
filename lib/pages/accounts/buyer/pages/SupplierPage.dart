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
  late Future<List<Product>> _supplierProducts;

  @override
  void initState() {
    _loadSupplierProducts();
    super.initState();
  }

  void _loadSupplierProducts() async {
    Product_Api productApi = Product_Api();

    //getting the current active supplier Id
    _supplierProducts = productApi.fetchAllSupplierProducts(widget.account!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            actions: [
              Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(Icons.search)),
              const SizedBox(
                width: 5.0,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(Icons.bookmark_border_outlined)),
              const SizedBox(
                width: 5.0,
              ),
            ],
            snap: false,
            pinned: true,
            floating: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
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
                      Text('Products', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05
                    ),),
                    TextButton(onPressed: (){}, child: const Text('Sort By'))],
                  ),
                  FutureBuilder<List<Product>>(
                      future: _supplierProducts,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<Product> supplierProducts = snapshot.data!;
                          return GridView.builder(
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
