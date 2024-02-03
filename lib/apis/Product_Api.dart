import 'dart:io';

import 'package:AfriMed/models/SupplierProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/Product.dart';

class Product_Api {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  Future<String?> createPlatformProduct (Product product) async {

    // Reference to the FireStore collection
    CollectionReference productsReference = _firebaseFirestore.collection(
        'products');

    // Data to be added, including nested fields like location
    Map<String, dynamic> newProduct = {
      'id': "",
      'name': product.name,
      'description': product.description,
      'category': product.category,
    };

    try {
      //step 1: save the details of the product to obtain the product id from the db
      DocumentReference docRef = await productsReference.add(newProduct);

      //get the product id
      String pId = docRef.id;

      //update the id of the product
      await productsReference.doc(pId).update({
        "id": pId
      });

      final productRef = storageRef.child('products_images/$pId');

      // Upload each image to the product's folder
      for(int i= 0; i < product.images!.length ; i++){
        String imageName = File(product.images?[i]).uri.pathSegments.last;
        final imageRef = productRef.child(imageName);

        // Upload image to the product's folder
        await imageRef.putFile(File(product.images?[i]));

        // Get the download URL for each image
        String imageDownloadUrl = await imageRef.getDownloadURL();

        // Perform any additional actions with the download URL if needed

        await docRef.update({
          'images': FieldValue.arrayUnion([imageDownloadUrl]),
        });

        await docRef.update({
          'thumbnail': imageDownloadUrl,
        });
      }

      return "Product added successfully";
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }

  //API TO CREATE A NEW SUPPLIER PRODUCT
  Future<String?> createSupplierProduct (SupplierProduct product) async {

    // Reference to the FireStore collection
    CollectionReference productsReference = _firebaseFirestore.collection(
        'users/${product.supplierId}/products');

    // Data to be added, including nested fields like location
    Map<String, dynamic> newProduct = {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'category': product.category,
      'price': product.price,
      'discountPercentage': product.discountPercentage,
      'stock': product.stock,
      'thumbnail': product.thumbnail,
      'images': product.images,
      'supplierId': product.supplierId
    };

    try {
      await productsReference.add(newProduct);

      return "Product added successfully";
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }

  Future<String?> updateSupplierProduct (SupplierProduct product) async {

    // Reference to the FireStore collection
    CollectionReference productsReference = _firebaseFirestore.collection(
        'products');

    // Data to be added, including nested fields like location
    Map<String, dynamic> updatedProduct = {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'category': product.category,
      'price': product.price,
      'discountPercentage': product.discountPercentage,
      'stock': product.stock,
    };

    try {
      //step 1: save the details of the product to obtain the product id from the db
      DocumentReference docRef = await productsReference.add(updatedProduct);

      //update the id of the product
      await productsReference.doc(product.id).update({
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'category': product.category,
        'price': product.price,
        'discountPercentage': product.discountPercentage,
        'stock': product.stock,
      });


      final productRef = storageRef.child('products_images/$product');

      // Upload each image to the product's folder
      for(int i= 0; i < product.images!.length ; i++){
        String imageName = File(product.images?[i]).uri.pathSegments.last;
        final imageRef = productRef.child(imageName);

        // Upload image to the product's folder
        await imageRef.putFile(File(product.images?[i]));

        // Get the download URL for each image
        String imageDownloadUrl = await imageRef.getDownloadURL();

        // Perform any additional actions with the download URL if needed

        await docRef.update({
          'images': FieldValue.arrayUnion([imageDownloadUrl]),
        });

        await docRef.update({
          'thumbnail': imageDownloadUrl,
        });
      }

      return "Product added successfully";
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }

  //fetching all the products of an active supplier by
  Future<List<SupplierProduct>> fetchAllSupplierProducts(String? sId) async {

    try {
      CollectionReference productsCollection = _firebaseFirestore.collection('users/$sId/products');
      QuerySnapshot querySnapshot = await productsCollection.get();

      List<SupplierProduct> productList = querySnapshot.docs
          .map((doc) => SupplierProduct.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      rethrow;
    }
  }

  //fetching the product depending on the entered criteria
  Future<List<Product?>> fetchProducts () async {
    try {
      CollectionReference productsCollection = _firebaseFirestore.collection(
          'products');

      QuerySnapshot querySnapshot = await productsCollection.get();


      List<Product> productList = querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return productList;
    } catch (e) {
      print("Error fetching products: $e");
      rethrow;
    }
  }
}
