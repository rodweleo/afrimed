import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'edit_supplier_product_page.dart';

class SupplierProductPage extends StatefulWidget {
  const SupplierProductPage({super.key, required this.product});
  final SupplierProduct product;

  @override
  State<SupplierProductPage> createState() => _SupplierProductPageState();
}

class _SupplierProductPageState extends State<SupplierProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                        items: widget.product.images!
                            .map((item) => SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 10,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => SizedBox(
                                      height: 10,
                                      width: MediaQuery.of(context).size.width,
                                      child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                  imageUrl: item,
                                  fit: BoxFit.fill,
                                ),
                              )
                          ),
                        ))
                            .toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                            disableCenter: false,
                            viewportFraction: 1.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.category,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.02)),
                        Text(widget.product.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.04)),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.75),
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                              decoration: TextDecoration.none),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'KSH ${widget.product.price}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.product.discountPercentage} %',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Stock:',
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).size.height * 0.025
                                ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.product.stock.toString(), style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.03
                            ),)
                          ],
                        ),
                      ],
                    ),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProduct(product: widget.product,)),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_document),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Edit Product'),
                            ],
                          )),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)))),
                          onPressed: () async {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Delete Product'),
                            ],
                          )),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
