import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../models/SupplierProduct.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final SupplierProduct product;
  static const kTransparentImage =
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAApklEQVR42mP8//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.5),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
            )
          ]
      ),
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.5),
              child: CachedNetworkImage(
                placeholder: (context, url) => const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 100,
                width: 100,
                imageUrl:
                widget.product.thumbnail!,
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.product.category),
                    /*SizedBox(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 14,
                ),
              ),
              Text('Bottles')*/
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unit Price',
                          style: TextStyle(color: Colors.black.withOpacity(0.4)),
                        ),
                        Text('KSh ${widget.product.price.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Purchase Price',
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.4))),
                        Text('KSh ${widget.product.price.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Created At:',
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.4))),
                        Text(DateTime.now().toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),

                  ],
                )
              ],
            )
          ]),
    );
  }
}
