import 'package:AfriMed/models/CartItem.dart';
import 'package:AfriMed/models/Product.dart';
import 'package:AfriMed/pages/accounts/buyer/widgets/SellerInformation.dart';
import 'package:AfriMed/providers/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        elevation: 1,
          ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            width: double.infinity,
            child: CachedNetworkImage(
              placeholder: (context, url) => const SizedBox(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 50,
              width: 50,
              imageUrl:
              product.imageUrl!,
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
                                    'KSh ${(((100 - product.discountPercentage) /
                                        100) *
                                        product.price)
                                        .roundToDouble()
                                        .toString()}',
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
                        SellerInformation(product: product),
                        const Divider(),
                        //SimilarProducts(product: product)
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
