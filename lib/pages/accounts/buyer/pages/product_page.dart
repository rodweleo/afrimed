import 'package:AfriMed/models/CartItem.dart';
import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:AfriMed/providers/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});
  final SupplierProduct? product;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int cartQuantity = cartProvider.getCartItemQuantity(product!);

    int productCartIndex = cartProvider.cartItems
        .indexWhere((cartItem) => cartItem.product?.id == product?.id);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CarouselSlider(
                  items: product?.images!
                      .map((item) => SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 10,
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl: item,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      disableCenter: false,
                      viewportFraction: 1.0)),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!.category,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .02,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product!.name,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'KSh ${(((100 - product!.discountPercentage) / 100) * product!.price).roundToDouble().toString()}',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                product!.price.toString(),
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
                            "-${product!.discountPercentage}%",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                color: Colors.green),
                          ),
                        ]),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * .02,
                          ),
                        ),
                        Text(
                          product!.description,
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: product?.stock == 0
                      ? null
                      : () {
                          cartProvider
                              .removeFromCart(CartItem(product: product));
                        }),
              Text(cartQuantity.toString()),
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: product?.stock == 0
                      ? null
                      : () {
                          cartProvider.addToCart(CartItem(product: product));
                        })
            ]),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor:
                        Theme.of(context).colorScheme.secondary,
                    disabledForegroundColor: Colors.white.withOpacity(0.5),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
                onPressed: product?.stock == 0
                    ? null
                    : () {
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
