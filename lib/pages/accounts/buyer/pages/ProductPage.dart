import 'package:connecta/models/CartItem.dart';
import 'package:connecta/models/Product.dart';
import 'package:connecta/pages/accounts/buyer/widgets/SellerInformation.dart';
import 'package:connecta/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ShoppingCart.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int cartQuantity = cartProvider.getCartItemQuantity(product);

    int productCartIndex = cartProvider
        .cartItems
        .indexWhere((cartItem) => cartItem.product.id == product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingCart()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              print('sharing');
            },
          ),
          Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShoppingCart()),
                  );
                },
              ),
              Positioned(
                  top: 0,
                  right: 2.5,
                  child: Container(
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Center(
                      child: Text(cartQuantity.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035)),
                    ),
                  ))
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: product.name,
              image: product.imageUrl!,
              height: 150,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    (((100 - product.discountPercentage) /
                                                100) *
                                            product.price)
                                        .roundToDouble()
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    product.price.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                        decorationThickness: 2),
                                  ),
                                ],
                              ),
                              Text(
                                "-${product.discountPercentage}%",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green),
                              ),
                            ]),
                        const SizedBox(height: 15),
                        Text(
                          product.description,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(),
                        const SellerInformation(),
                        const Divider(),
                        Text(
                          'Similar This',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                product.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              IconButton(icon: const Icon(Icons.remove), onPressed: () {
                cartProvider.removeFromCart(CartItem(product: product));
              }),
              Text(cartQuantity.toString()),
              IconButton(icon: const Icon(Icons.add), onPressed: () {
                cartProvider.addToCart(CartItem(product: product));
              })
            ]),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey,
                    disabledForegroundColor: Colors.white.withOpacity(0.5),
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                onPressed: () {
                  //check whether the product is in the shopping cart
                  if (productCartIndex != -1) {
                    return;
                  } else {
                    cartProvider.addToCart(CartItem(product: product));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      productCartIndex != -1 ? 'ADDED TO CART ' : 'ADD TO CART',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
