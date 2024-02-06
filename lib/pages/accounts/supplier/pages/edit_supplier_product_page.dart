import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../apis/Product_Api.dart';
import '../../../../providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  EditProduct({super.key, required this.product});
  SupplierProduct product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ImagePicker imagePicker = ImagePicker();

  //creating the form key
  final _editProductKey = GlobalKey<FormState>();
  final List<String> _productCategories = [
    'Painkillers',
    'Antibiotics',
    'Anti-inflammatory',
    'Anti-fungal',
    'Antiviral'
  ];

  //creating controllers for the form
  final TextEditingController _productNameController = TextEditingController();
  String _productCategory = "";
  final TextEditingController _productDescriptionController =
  TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();
  final TextEditingController _productDiscountPercentageController =
  TextEditingController();
  String thumbnail = "";
  List images = [];
  bool _isAddingProduct = false;

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productStockController.dispose();
    _productDiscountPercentageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _productNameController.text = widget.product.name ?? "";
    _productCategory = widget.product.category ?? "";
    _productDescriptionController.text = widget.product.description ?? "";
    _productPriceController.text = widget.product.price.toString();
    _productDiscountPercentageController.text = widget.product.discountPercentage.toString();
    _productStockController.text = widget.product.stock.toString();

    //initializing the default thumbnail to the product's default image
    thumbnail = widget.product.thumbnail ?? "";
    images = widget.product.images ?? [];
    super.initState();
  }

  Future<String?> _updateProduct() async {
    //make the state to be submitting state
    setState(() {
      _isAddingProduct = true;
    });

    SupplierProduct editedProduct = SupplierProduct(
        id: widget.product.id,
        name: _productNameController.text,
        category: _productCategory,
        description: _productDescriptionController.text,
        thumbnail: widget.product.thumbnail,
        images: images,
        price: double.parse(_productPriceController.text),
        discountPercentage:
        double.parse(_productDiscountPercentageController.text),
        stock: int.parse(_productStockController.text),
        supplierId: widget.product.supplierId
    );

    //try adding the product into the database
    Product_Api productApi = Product_Api();
    String? feedback =
        await productApi.updateSupplierProduct(editedProduct);
    return feedback;
  }

  void _pickProductImageFromGallery() async {

    try {
      final List selectedImages = await imagePicker.pickMultiImage();

      if (selectedImages.isNotEmpty) {
        //iterate through the array and extract the path then push them to the image file path list
        for(int i = 0; i < selectedImages.length; i++){
          String imagePath = selectedImages[i].path;

          //add the image path to the
          images.add(imagePath);
        }
      }

      setState(() {});
    } catch (e) {
      // Provide a more user-friendly error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to pick an image. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _editProductKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _productNameController,
                  onChanged: (value) {
                    _productNameController.text = value;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black)),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(12, 10, 20, 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "poppins",
                      ),
                      hint: const Text(
                        "Select Product Category",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      value: _productCategory,
                      items: _productCategories
                          .map<DropdownMenuItem<String>>(
                            (category) => DropdownMenuItem(
                          value: category.capitalize,
                          child: Text(category.toString()),
                        ),
                      )
                          .toList(),
                      isExpanded: true,
                      isDense: true,
                      onChanged: (String? value) => setState(
                            () {
                          if (value != null) _productCategory = value;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _productDescriptionController,
                  onChanged: (value) {
                    _productDescriptionController.text = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description for the product';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _productPriceController,
                  onChanged: (value) {
                    _productPriceController.text = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black)),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product's price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),

                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _productDiscountPercentageController,
                  onChanged: (value) {
                    _productDiscountPercentageController.text = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Discount Percentage',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black)),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product's discount percentage";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _productStockController,
                  onChanged: (value) {
                    _productStockController.text = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.black)),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product's stock";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
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
                       autoPlay: false,
                       autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                       disableCenter: false,
                       viewportFraction: 1.0))
                    ,
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)))),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_editProductKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        String? feedback = await _updateProduct();
                        if (feedback != null) {
                          setState(() {
                            _isAddingProduct = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(feedback)),
                          );

                          //reset the whole form
                          _editProductKey.currentState!.reset();
                        }
                      }
                    },
                    child: _isAddingProduct
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
