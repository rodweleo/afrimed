import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../apis/Product_Api.dart';
import '../../../../models/Product.dart';


class AddPlatformProduct extends StatefulWidget {
  const AddPlatformProduct({super.key});

  @override
  State<AddPlatformProduct> createState() => _AddPlatformProductState();
}

class _AddPlatformProductState extends State<AddPlatformProduct> {
  //creating the form key
  final _addProductKey = GlobalKey<FormState>();
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
  //THE IMAGES FOR EACH PRODUCT
  final ImagePicker imagePicker = ImagePicker();
  List imageFileList = [];
  String productImagePath = "";
  bool _isAddingProduct = false;
  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _productCategory = _productCategories[0];
    super.initState();
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
        thumbnail: "",
        images: imageFileList,
    );

    //try adding the product into the database
    Product_Api productApi = Product_Api();
    String? feedback = await productApi.createPlatformProduct(newProduct);

    return feedback;
  }

  void _pickProductImageFromGallery() async {
    try {
      final List selectedImages = await imagePicker.pickMultiImage();

      if (selectedImages.isNotEmpty) {
        //iterate through the array and extract the path then push them to the image file path list
        for(var i = 0; i < selectedImages.length; i++){
          String imagePath = selectedImages[i].path;

          //add the image path to the
          imageFileList.add(imagePath);
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
            content: Text('Failed to pick an image: $e'),
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
      body: SingleChildScrollView(
        child: Container(
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 10, 20, 20),
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
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
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
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Try to upload the image of your product here',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            )
                          ],
                        )),
                    onTap: () {
                      _pickProductImageFromGallery();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageFileList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(
                                File(imageFileList[index]),
                                fit: BoxFit.fill,
                              ),
                            );
                          }),
                    ),
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
      ),
    );
  }
}
