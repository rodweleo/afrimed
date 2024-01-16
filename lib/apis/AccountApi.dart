import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Account.dart';
import '../models/ShippingAddress.dart';


class AccountApi {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> createAccount(String? uId, Account account) async {
    // Reference to the FireStore collection
    CollectionReference usersReference = _firebaseFirestore.collection('users');

    // Data to be added, including nested fields like location
    Map<String, dynamic> newAccount = {
      'name': account.name,
      'businessInformation': {
        'businessName': account.businessInfo.businessName,
        'businessCategory': account.businessInfo.businessCategory
      },
      'role': account.role,
      'contact': {
        'email': account.contact.email,
        'phoneNumber': account.contact.phoneNumber
      },
      'location': {
        'county': account.location.county,
        'town': account.location.town,
        'address': account.location.address,
      },
      'hasUploadedIdentificationDocuments': account.hasUploadedIdentificationDocuments,
      'isVerified': account.isVerified
    };

    try {
      // Add the data to FireStore
      await usersReference.doc(uId).set(newAccount).then((value){
        return 'Supplier account created successfully!';
      });

    } catch (e) {
      return null;
    }

    return null;
  }

  //update the shipping address of the buyers
  Future<String?> addShippingAddress(String accountId, ShippingAddress shippingAddress) async {
    // Reference to the FireStore collection
    CollectionReference shippingAddressesReference = _firebaseFirestore.collection('users').doc(accountId).collection("shipping_addresses");

    // Data to be added, including nested fields like location
    Map<String, dynamic> newShippingAddress = {
      'address': shippingAddress.address,
      'town': shippingAddress.town,
      'county': shippingAddress.county,
    };

    try {
      // Add the data to FireStore
      await shippingAddressesReference.add(newShippingAddress);

      return 'Shipping address added successfully';

    } catch (e) {
      return null;
    }

  }
  
  Future<Account?> fetchAccountById(String? id) async {
    CollectionReference usersReference = _firebaseFirestore.collection('users');
    DocumentReference documentReference = usersReference.doc(id);

    try {
      DocumentSnapshot doc = await documentReference.get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        BusinessInfo businessInfo = BusinessInfo(
          businessCategory: data['businessInformation']['businessCategory'],
          businessName: data['businessInformation']['businessName'],
        );

        Contact contact = Contact(
          email: data['contact']['email'],
          phoneNumber: data['contact']['phoneNumber'],
        );

        Location location = Location(
          county: data['location']['county'],
          town: data['location']['town'],
          address: data['location']['address'],
        );

        Account account = Account(
          id: data['id'],
          name: data['name'],
          businessInfo: businessInfo,
          contact: contact,
          location: location,
          role: data['role'], // You need to get the role from data
          hasUploadedIdentificationDocuments: data['hasUploadedIdentificationDocuments'],
          isVerified: data['isVerified'],
            imageUrl: data['imageUrl'],
        );


        return account;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //get account shipping address
  Future<List<ShippingAddress>?> fetchAccountShippingAddress(String? id) async {
    try {
      CollectionReference shippingAddressesReference = _firebaseFirestore
          .collection('users').doc(id).collection('shipping_addresses');

      QuerySnapshot querySnapshot = await shippingAddressesReference.get();

      List<ShippingAddress> shippingAddressList = querySnapshot.docs
          .map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return ShippingAddress(
          address: data['address'] ?? '',
          town: data['town'] ?? '',
          county: data['county'] ?? '',
        );
      })
          .toList();

      return shippingAddressList;
    } catch (error) {
      // Handle any errors that might occur during the fetch operation
      print('Error fetching shipping addresses: $error');
      return null; // Return an empty list or handle the error as appropriate for your application
    }
  }


  Future<List<Account>> fetchAllSuppliers() async {
    CollectionReference usersCollection = _firebaseFirestore.collection("users");

    try {
      QuerySnapshot querySnapshot = await usersCollection
          .where('role', isEqualTo: 'supplier')
          .get();

      List<Account> supplierList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        BusinessInfo businessInfo = BusinessInfo(
          businessCategory: data['businessInformation']['businessCategory'],
          businessName: data['businessInformation']['businessName'],
        );

        Contact contact = Contact(
          email: data['contact']['email'],
          phoneNumber: data['contact']['phoneNumber'],
        );

        Location location = Location(
          county: data['location']['county'],
          town: data['location']['town'],
          address: data['location']['address'],
        );

        return Account(
          id: data['id'],
          name: data['name'],
          businessInfo: businessInfo,
          contact: contact,
          location: location,
          role: data['role'],
          hasUploadedIdentificationDocuments: data['hasUploadedIdentificationDocuments'] ?? false,
          isVerified: data['isVerified'] ?? false,
          imageUrl: data['imageUrl'],
        );
      }).toList();

      return supplierList;
    } catch (e) {
      // Handle errors, log, or rethrow if necessary
      return [];
    }
  }



}