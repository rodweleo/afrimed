import 'package:AfriMed/models/Account.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/product_page.dart';
import 'package:AfriMed/pages/accounts/supplier/widgets/cards/supplierProductCard.dart';
import 'package:flutter/material.dart';
import '../../../../apis/Product_Api.dart';
import 'package:provider/provider.dart';
import '../../../../models/CartItem.dart';
import '../../../../models/SupplierProduct.dart';
import '../../../../providers/cart_provider.dart';
import 'shopping_cart_page.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key, required this.account});
  final Account account;
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

  Future<List<SupplierProduct>> _loadSupplierProducts() async {
    Product_Api productApi = Product_Api();

    // Getting the current active supplier Id
    List<SupplierProduct> allProducts =
    await productApi.fetchAllSupplierProducts(widget.account.id!);

    // Filter products based on the search query
    List<SupplierProduct> filteredProducts = allProducts
        .where((product) =>
        product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return filteredProducts;
  }


  @override
  Widget build(BuildContext context) {
    //get the elements in the cart that are a given supplier's
    List<CartItem> items = Provider.of<CartProvider>(context, listen: true).getSupplierItemsInCart(widget.account.id!);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            snap: false,
            pinned: true,
            floating: false,
            expandedHeight: 200,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_rounded, color: Colors.black,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShoppingCart(account: widget.account,)),
                      );
                    },
                  ),
                  Positioned(
                      top: 0,
                      right: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Text(items.length.toString(), style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.015,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                      ))
                ],
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.25)),
                child: widget.account.imageUrl != ""
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.account.imageUrl))
                    : Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.height * 0.075,
                        color: Theme.of(context).colorScheme.primary,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.account.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(widget
                                  .account.contact.email,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis
                                  ),
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    widget.account.contact.phoneNumber
                                        .toString(),
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
                          height: 50,
                          child: TextFormField(
                            controller: _searchBoxController,
                            onChanged: (String? value){
                              setState(() {
                                searchQuery = _searchBoxController.text;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              hintText: 'Search product...',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10), // Optional padding
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  FutureBuilder<List<SupplierProduct>>(
                      future: _loadSupplierProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<SupplierProduct> supplierProducts = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: supplierProducts.length,
                              itemBuilder: (context, index) {
                                SupplierProduct product = supplierProducts[index];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductPage(product: product)),
                                    );
                                  },
                                    child: SupplierProductCard(product: product)
                                );
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
