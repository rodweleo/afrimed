import 'package:AfriMed/models/Product.dart';
import 'package:AfriMed/pages/accounts/buyer/pages/ProductPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1,3), // changes position of shadow
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // this is the column
          children: [
            SizedBox(
              height: 100,
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
            Container(
              color: Colors.white12,
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            product.name,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          )),
                          /*Row(
                            children: [
                              Text(product.rating.toString(),
                                  style: const TextStyle(fontSize: 12)),
                              const Icon(
                                Icons.star,
                                size: 15,
                              ),
                            ],
                          )*/
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.description,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'KSh ${product.price * (1 - (product.discountPercentage / 100))}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade900,
                              ),
                            ),
                            product.discountPercentage > 0.0 ? Text(
                              "-${product.discountPercentage}%",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                                fontStyle: FontStyle.italic,
                              ),
                            ) : const Text(''),
                          ])
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
