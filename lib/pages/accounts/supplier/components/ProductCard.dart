import 'package:connecta/pages/accounts/supplier/pages/Product.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../models/Product.dart';

class ProductCard extends StatefulWidget {
  ProductCard({super.key, required this.product});
  final Product product;
  static const kTransparentImage =
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAApklEQVR42mP8//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product: widget.product),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 10.0),
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
                  placeholder: (context, url) => SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 100,
                  width: 100,
                  imageUrl:
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Purchase Price',
                              style:
                              TextStyle(color: Colors.black.withOpacity(0.4))),
                          Text('KSh ${widget.product.price.toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Created At:',
                              style:
                              TextStyle(color: Colors.black.withOpacity(0.4))),
                          Text(DateTime.now().toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      Icon(Icons.delete, color: Colors.red)
                    ],
                  )
                ],
              )
            ]),
      )
    );
  }
}
