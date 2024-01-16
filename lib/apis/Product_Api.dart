import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Product.dart';

class Product_Api {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> createProduct (Product product, File? productImage) async {

    // Reference to the FireStore collection
    CollectionReference productsReference = _firebaseFirestore.collection('products');

    // Data to be added, including nested fields like location
    Map<String, dynamic> newProduct = {
      'id': "",
      'name': product.name,
      'description': product.description,
      'category': product.category,
      'price': product.price,
      'discountPercentage': product.discountPercentage,
      'stock': product.stock,
      'imageUrl': product.imageUrl,
      'supplierId': product.supplierId
    };

    try {


        if(productImage != null){
          // Add the data to FireStore
          DocumentReference docRef = await productsReference.add(newProduct);

          //get the product id
          String pId = docRef.id;

          //update the id of the product
          await productsReference.doc(pId).update({
            "id": pId
          });

          //
          //use the product Id to store the image in the database in the storage database
          // under the root folder products_images, then create the download url that will
          // eventually update the product of the id and set the image url to the download url
          // we have created

          // Upload the image to Firebase Storage
          final csRef = FirebaseStorage.instance.ref().child('products_images/$pId.jpg');

          UploadTask uploadTask = csRef.putFile(productImage);

          await uploadTask.whenComplete(() async {
            // Once the image is uploaded, get the download URL
            String downloadUrl = await csRef.getDownloadURL();

            // Update the product in Firestore with the download URL
            await docRef.update({'imageUrl': downloadUrl});
          });

          String feedback = 'Product added!';
          return feedback;
        }else{
          // Add the data to FireStore
          DocumentReference docRef = await productsReference.add(newProduct);

          //get the product id
          String pId = docRef.id;

          //update the id of the product
          await productsReference.doc(pId).update({
            "id": pId
          });

          String feedback = 'Product added!';
          return feedback;
        }

    } catch (e) {
      print('Error adding supplier data: $e');
    }

    return null;
  }

  //fetching all the products of an active supplier by
  Future<List<Product>> fetchAllSupplierProducts(String sId) async {

    try {
      CollectionReference productsCollection = _firebaseFirestore.collection('products');
      QuerySnapshot querySnapshot = await productsCollection
          .where('supplierId', isEqualTo: sId)
          .get();

      List<Product> productList = querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      rethrow;
    }
  }


  Future<List<String>> fetchProductCategories() async {
    final response =
    await http.get(Uri.parse('https://dummyjson.com/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> categoryList = json.decode(response.body);

      return categoryList.cast<String>();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load products');
    }
  }

  /*Future<List<Product>> fetchCategoryProducts(String category) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/category/$category'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> productList = data["products"];
      List<Product> products =
      productList.map((product) => Product.fromJson(product)).toList();

      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load products');
    }
  }*/


}
