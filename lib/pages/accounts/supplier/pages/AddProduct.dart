import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../apis/Product_Api.dart';
import '../../../../models/Product.dart';
import '../../../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  //creating the form key
  final _addProductKey = GlobalKey<FormState>();
  final List<String> _productCategories = [
    'Pharmaceutical Products',
    'Non-Pharmaceutical Products'
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
  //TextEditingController _productManufacturingDateController = new TextEditingController();
  //TextEditingController _productExpiryDateController = new TextEditingController();
  File? _productImage;
  bool _isAddingProduct = false;
  @override
  void dispose() {
    _productNameController.dispose();
    _productNameController.clear();
    _productDescriptionController.dispose();
    _productDescriptionController.clear();
    _productPriceController.dispose();
    _productPriceController.clear();
    _productStockController.dispose();
    _productStockController.clear();
    _productDiscountPercentageController.dispose();
    _productDiscountPercentageController.clear();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _productCategory = _productCategories[0];
  }

  Future<String?> _addProduct() async {
    //make the state to be submitting state
    setState(() {
      _isAddingProduct = true;
    });

    Product newProduct = Product(
        id: '',
        name: _productNameController.text,
        category: _productCategory,
        description: _productDescriptionController.text,
        imageUrl: _productImage!.path,
        price: double.parse(_productPriceController.text),
        discountPercentage:
            double.parse(_productDiscountPercentageController.text),
        stock: int.parse(_productStockController.text),
        supplierId:
            Provider.of<UserProvider>(context, listen: false).user!.uid);

    //try adding the product into the database
    Product_Api productApi = Product_Api();
    String? feedback =
        await productApi.createProduct(newProduct, _productImage);

    return feedback;
  }

  void _pickProductImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final productImage = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (productImage != null) {
        setState(() {
          _productImage = File(productImage.path);
        });
      } else {
        return;
      }
    } catch (e) {
      // Handle exceptions related to image picking
      print('Error picking image: $e');

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
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _addProductKey,
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
                  maxLength: 100,
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
                /*TextFormField(
                  controller: _productManufacturingDateController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        _productManufacturingDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                  decoration: InputDecoration(
                    labelText: 'Manufacture Date',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black)
                    ),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product's manufacturing date";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _productExpiryDateController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(int.parse(_productManufacturingDateController.text)),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        _productExpiryDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                  decoration: InputDecoration(
                    labelText: 'Expiry Date',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black)
                    ),
                  ),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the product's expiry date";
                    }
                    return null;
                  },
                ),*/
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
                _productImage == null
                    ? GestureDetector(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5),
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.cloud_upload,
                                  size: 50,
                                  color: Colors.blueGrey,
                                ),
                                const Text(
                                  'Upload product image',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  'Try to upload the image of your product here',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                )
                              ],
                            )),
                        onTap: () {
                          _pickProductImage();
                        },
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Stack(children: [
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 5,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Image.file(_productImage!,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _pickProductImage();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_productImage!.path
                                              .split("/")
                                              .last),
                                          const Icon(
                                            Icons.edit_document,
                                            color: Colors.blueGrey,
                                          )
                                        ]),
                                  ))
                            ],
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap:(){
                                  //delete the product image from display
                                  setState((){
                                    _productImage = null;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50.0)),
                                  child: const Icon(Icons.close, color: Colors.white),
                                ),
                              ))
                        ])),
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
                      if (_addProductKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        String? feedback = await _addProduct();
                        if (feedback != null) {
                          setState(() {
                            _isAddingProduct = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(feedback)),
                          );

                          //reset the whole form
                          _addProductKey.currentState!.reset();
                        }
                      }
                    },
                    child: _isAddingProduct
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Submit'),
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
