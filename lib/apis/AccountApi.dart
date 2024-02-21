import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Account.dart';
import '../models/CartItem.dart';
import '../models/ShippingAddress.dart';

class AccountApi {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> createAccount(Account account) async {
    //when creating an account, if the account type is a supplier or a buyer
    //1. we need to create sub_collections for the account; products, shipping addresses, and the identification documents

    // Reference to the FireStore collection
    CollectionReference usersCollection =
        _firebaseFirestore.collection('users');

    // Data to be added, including nested fields like location
    Map<String, dynamic> newAccount = {
      "id": account.id,
      'name': account.name,
      'businessName': account.businessName,
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
      'hasUploadedIdentificationDocuments':
          account.hasUploadedIdentificationDocuments,
      'isVerified': account.isVerified,
      "imageURL": account.imageUrl,
      "username": account.username,
      "password": account.password
    };

    try {
      // save the account information
      DocumentReference documentReference =
          await usersCollection.add(newAccount);
      String docId = documentReference.id;

      //after getting the id, update the account id
      await usersCollection.doc(docId).update({"id": docId});

      return "Account created successfully";
    } catch (e) {
      return "$e";
    }
  }

  //update the shipping address of the buyers
  Future<String?> addShippingAddress(
      String accountId, ShippingAddress shippingAddress) async {
    // Reference to the FireStore collection
    CollectionReference shippingAddressesReference = _firebaseFirestore
        .collection('users')
        .doc(accountId)
        .collection("shipping_addresses");

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
            businessName: data["businessName"],
            contact: contact,
            location: location,
            role: data['role'],
            // You need to get the role from data
            hasUploadedIdentificationDocuments:
                data['hasUploadedIdentificationDocuments'],
            isVerified: data['isVerified'],
            imageUrl: data['imageUrl'] ?? "",
            username: data['username'],
            password: data['password']);

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
          .collection('users')
          .doc(id)
          .collection('shipping_addresses');

      QuerySnapshot querySnapshot = await shippingAddressesReference.get();

      List<ShippingAddress> shippingAddressList =
          querySnapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return ShippingAddress(
          address: data['address'] ?? '',
          town: data['town'] ?? '',
          county: data['county'] ?? '',
        );
      }).toList();

      return shippingAddressList;
    } catch (error) {
      // Handle any errors that might occur during the fetch operation
      print('Error fetching shipping addresses: $error');
      return null; // Return an empty list or handle the error as appropriate for your application
    }
  }

  Future<List<Account>> fetchAllSuppliers() async {
    CollectionReference usersCollection =
        _firebaseFirestore.collection("users");

    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('role', isEqualTo: 'supplier').get();

      List<Account> supplierList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

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
            businessName: data['businessName'],
            contact: contact,
            location: location,
            role: data['role'],
            hasUploadedIdentificationDocuments:
                data['hasUploadedIdentificationDocuments'] ?? false,
            isVerified: data['isVerified'] ?? false,
            imageUrl: data['imageUrl'] ?? "",
            username: data['username'],
            password: data['password']);
      }).toList();

      return supplierList;
    } catch (e) {
      // Handle errors, log, or rethrow if necessary
      return [];
    }
  }

  Future<String?> fetchUserRoleById(String? id) async {
    AccountApi accountApi = AccountApi();
    Account? account = await accountApi.fetchAccountById(id);
    if (account?.role != null) {
      String? role = account?.role;
      return role;
    } else {
      return null;
    }
  }

  //ACTIONS FOR THE BUYER ACCOUNT

  //fetch the cart items of one buyer by using the id
  Future<List<CartItem>?> fetchBuyerCartItems(String? id) async {
    //creating the carts collections
    CollectionReference cartsRef = _firebaseFirestore.collection('carts');

    //fetch the document that has the id of the buyer
    DocumentReference cartRef = cartsRef.doc(id);

    try {
      DocumentSnapshot doc = await cartRef.get();

      if (doc.exists) {
        //retrieve the products in that
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  //login with username and password set by the creator of the account
  Future<Account?> signInWithUsernameAndPassword(username, password) async {
    // Create a reference to the users collection
    CollectionReference usersRef = _firebaseFirestore.collection('users');

    // Create a query against the collection to get the document with the matching username and password
    Query q = usersRef.where("username", isEqualTo: username).where(
          "password",
          isEqualTo: password,
        );
    try {
      QuerySnapshot querySnapshot = await q.get();
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            (querySnapshot.docs.first.data() as Map<String, dynamic>);

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
            role: data['role'],
            contact: contact,
            location: location,
            businessName: data['businessName'],
            hasUploadedIdentificationDocuments:
                data['hasUploadedIdentificationDocuments'] ?? false,
            isVerified: data['isVerified'] ?? false,
            imageUrl: data['imageUrl'] ?? "",
            username: data['username'],
            password: data['password']);

        return account;
      } else {
        return null; // No matching user found
      }
    } catch (e) {
      // Handle errors, log, or rethrow if necessary
      print("Error: $e");
      return null;
    }
  }
}
