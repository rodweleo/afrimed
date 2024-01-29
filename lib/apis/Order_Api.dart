import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/CartItem.dart';
import '../models/OrderProduct.dart';
import 'package:provider/provider.dart';
import '../models/ProductOrder.dart';
import '../models/ShippingAddress.dart';
import '../providers/cart_provider.dart';
import 'package:flutter/material.dart';

class Order_Api{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //creating a new order
  Future <String?> createOrder(String? buyerId, orders, ShippingAddress? shippingAddress, BuildContext context) async {
  CollectionReference ordersRef = _firebaseFirestore.collection("orders");

  for (var supplierId in orders.keys) {
    List<CartItem> supplierCartItem = orders[supplierId] ?? [];

    Map<String, dynamic> newOrder = {
      'id': "",
      'buyerId': buyerId,
      'supplierId': supplierId,
      'products': supplierCartItem.map((cartItem) =>
          OrderProduct(
            productId: cartItem.product.id,
            name: cartItem.product.name,
            supplierId: cartItem.product.supplierId,
            orderQuantity: cartItem.quantity,
            totalAmount: cartItem.product.price * cartItem.quantity,
            imageURL: cartItem.product.imageUrl!
          ).toMap())
          .toList(),
      'totalAmount': Provider.of<CartProvider>(context, listen: false).getTotal(supplierId: supplierId),
      'shippingAddress' : {
        'address': shippingAddress?.address,
        'town': shippingAddress?.town,
        'county': shippingAddress?.county,
      },
      'status': 'PENDING',
      'createdOn' : DateTime.timestamp().toLocal()
    };

    try {
      DocumentReference docRef = await ordersRef.add(newOrder);
      String orderId = docRef.id;

      //updating the record's id
      await docRef.update({
        'id': orderId
      });

      return 'Order created successfully!';

    } catch (e) {
      print('Error occurred while creating order: $e');
      return "";
    }
  }
  return null;

}

  //retrieving the orders of a buyer
  Future<List<ProductOrder>?> fetchBuyerOrders(String buyerId) async {
    try {
      CollectionReference ordersRef = _firebaseFirestore.collection('orders');
      QuerySnapshot querySnapshot = await ordersRef
          .where('buyerId', isEqualTo: buyerId)
          .get();

      List<ProductOrder> orderList = querySnapshot.docs
          .map((doc) => ProductOrder.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return orderList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //fetching the orders for one supplier
  Future<List<ProductOrder>?> fetchSupplierOrders(String? supplierId) async {
    try {
      CollectionReference productsCollection = _firebaseFirestore.collection('orders');
      QuerySnapshot querySnapshot = await productsCollection
          .where('supplierId', isEqualTo: supplierId)
          .get();

      List<ProductOrder> orderList = querySnapshot.docs
          .map((doc) => ProductOrder.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      return orderList;
    } catch (e) {
      return null;
    }
  }
}
