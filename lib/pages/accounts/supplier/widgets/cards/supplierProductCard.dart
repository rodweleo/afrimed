import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupplierProductCard extends StatelessWidget {
  final SupplierProduct? product;

  const SupplierProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          child: CachedNetworkImage(
            placeholder: (context, url) => const SizedBox(
                height: 5, width: 5, child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 50,
            width: 50,
            imageUrl: product!.thumbnail!,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'KSh ${product!.price * (1 - (product!.discountPercentage / 100))}',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    product!.discountPercentage > 0.0
                        ? Text(
                            "-${product?.discountPercentage}%",
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : const Text(''),
                  ])
            ],
          ),
        )
      ],
    );
  }
}
