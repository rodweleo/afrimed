import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
Future<void> createBuyer() async {
  // Reference to the Firestore collection
  CollectionReference suppliers = _firebaseFirestore.collection('suppliers');

  // Data to be added, including nested fields like location
  Map<String, dynamic> supplier = {
    'name': 'AfriMed Suppliers',
    'businessInformation':{
      'businessName': 'AfriMed',
      'businessCategory': 'Pharmaceticals'
    },
    'contact': {
      'email': 'afrimed@example.com',
      'phoneNumber': 254795565344
    },
    'location': {
      'county': 'Nairobi',
      'estate': 'Umoja',
    },
  };

  try {
    // Add the data to Firestore
    DocumentReference documentReference = await suppliers.add(supplier);
    print(documentReference);
    print('Supplier data added successfully!');
  } catch (e) {
    print('Error adding supplier data: $e');
  }
}