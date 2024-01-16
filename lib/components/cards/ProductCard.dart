import 'package:connecta/models/Product.dart';
import 'package:connecta/pages/accounts/buyer/pages/ProductPage.dart';
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
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.5))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // this is the column
          children: [
            SizedBox(
              height: 110,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                placeholder: product.name,
                image: product.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
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
                            'KSh ${product.price}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                          Text(
                            "-${product.discountPercentage}%",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ])
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
