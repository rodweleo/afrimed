import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ShoppingOrder.dart';

class Order_Api {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //creating a new order
  Future<String?> createOrder(ShoppingOrder order) async {
    CollectionReference ordersRef = _firebaseFirestore.collection("orders");

    Map<String, dynamic> newOrder = {
      'id': "",
      'buyerId': order.buyerId,
      'supplierId': order.supplierId,
      'products': order.products.map((item) => item.toMap()).toList(),
      'paymentMethod': order.paymentMethod,
      'paymentStatus': order.paymentStatus,
      'discount': order.discount,
      'totalAmount': order.totalAmount,
      'shippingAddress': {
        'address': order.shippingAddress?.address,
        'town': order.shippingAddress?.town,
        'county': order.shippingAddress?.county,
      },
      'status': order.status,
      'createdOn': order.createdOn
    };

    try {
      DocumentReference docRef = await ordersRef.add(newOrder);
      String orderId = docRef.id;

      //updating the record's id
      await docRef.update({'id': orderId});

      return orderId;
    } catch (e) {
      print('Error occurred while creating order: $e');
      return null;
    }
  }

  //retrieving the orders of a buyer
  Future<List<ShoppingOrder>?> fetchBuyerOrders(String buyerId) async {
    try {
      CollectionReference ordersRef = _firebaseFirestore.collection('orders');
      QuerySnapshot querySnapshot =
          await ordersRef.where('buyerId', isEqualTo: buyerId).get();

      List<ShoppingOrder> orderList = querySnapshot.docs
          .map((doc) =>
              ShoppingOrder.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return orderList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //fetching the orders for one supplier
  Future<List<ShoppingOrder>?> fetchSupplierOrders(String? supplierId) async {
    try {
      CollectionReference productsCollection =
          _firebaseFirestore.collection('orders');
      QuerySnapshot querySnapshot = await productsCollection
          .where('supplierId', isEqualTo: supplierId)
          .get();

      List<ShoppingOrder> orderList = querySnapshot.docs
          .map((doc) =>
              ShoppingOrder.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return orderList;
    } catch (e) {
      return null;
    }
  }

  //cancelling an order
  Future<String> cancelOrder(String orderId) async {
    try {
      CollectionReference ordersReference =
          _firebaseFirestore.collection('orders');

      //update the order with the id
      await ordersReference.doc(orderId).update({'status': 'CANCELLED'});

      return 'Order $orderId cancelled.';
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }

  //confirming an order
  Future<String> confirmOrder(String orderId) async {
    try {
      CollectionReference ordersReference =
          _firebaseFirestore.collection('orders');

      //update the order with the id
      await ordersReference.doc(orderId).update({'status': 'CONFIRMED'});

      return 'Order $orderId confirmed.';
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }

  Future<String> transportOrder(String orderId) async {
    try {
      CollectionReference ordersReference =
          _firebaseFirestore.collection('orders');

      //update the order with the id
      await ordersReference.doc(orderId).update({'status': 'IN TRANSIT'});

      return 'Order $orderId on transit.';
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }

  Future<String> deliverOrder(String orderId) async {
    try {
      CollectionReference ordersReference =
          _firebaseFirestore.collection('orders');

      //update the order with the id
      await ordersReference.doc(orderId).update({'status': 'DELIVERED'});

      return 'Order $orderId delivered.';
    } catch (e) {
      return 'An error has occurred: $e';
    }
  }
}
