import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final SupplierProduct? product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        leading: CachedNetworkImage(
          placeholder: (context, url) => const SizedBox(
              height: 5, width: 5, child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: MediaQuery.of(context).size.height,
          imageUrl: product!.thumbnail!,
          fit: BoxFit.fill,
        ),
        title:  Text(
          product!.category,
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
              fontSize:
              MediaQuery.of(context).size.width * 0.025,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product!.name,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  fontSize:
                  MediaQuery.of(context).size.width * 0.045,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              product!.description,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KSh ${product!.price * (1 - (product!.discountPercentage / 100))}',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  product!.discountPercentage > 0.0
                      ? Text(
                    "-${product?.discountPercentage}%",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                      : const Text('0.0'),
                ]),
            Row(
              children: [
                const Text('Stock:'),
                const SizedBox(
                  width: 10,
                ),
                Text(product!.stock.toString(), style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
