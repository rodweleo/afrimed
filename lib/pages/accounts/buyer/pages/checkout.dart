import 'package:AfriMed/components/success_page/OrderSuccessful.dart';
import 'package:AfriMed/models/CartItem.dart';
import 'package:AfriMed/models/ShoppingOrder.dart';
import 'package:AfriMed/pages/accounts/buyer/widgets/CheckoutPaymentInformation.dart';
import 'package:AfriMed/pages/accounts/buyer/widgets/CheckoutShippingAddress.dart';
import 'package:AfriMed/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../apis/Order_Api.dart';
import '../../../../models/Account.dart';
import 'package:AfriMed/providers/cart_provider.dart';
import '../../../../models/ShippingAddress.dart';
import 'package:intl/intl.dart';

class Checkout extends StatefulWidget {
  Checkout({super.key, required this.account});
  Account account;
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {


  ShippingAddress? selectedShippingAddress;
  String selectedPaymentMethod = "";
  String paymentStatus = "";

  void _createOrder(String buyerId, String supplierId, List<CartItem> products, double totalAmount) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(color: Colors.black,),
                const SizedBox(
                  width: 20,
                ),
                Text('Processing Order...', style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05
                ),)
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),

          );
        });

    Order_Api orderApi = Order_Api();

    ShoppingOrder newOrder = ShoppingOrder(
      id: "",
      buyerId: buyerId,
      supplierId: supplierId,
      products: products,
      totalAmount: totalAmount,
      paymentMethod: selectedPaymentMethod,
      paymentStatus: paymentStatus,
      discount: 0.0,
      shippingAddress: selectedShippingAddress,
      status: 'PENDING',
      createdOn: DateFormat.yMMMEd().format(DateTime.now()),
    );
    String? orderId = await orderApi.createOrder(newOrder);

    if(orderId != null){

      //if the order has been successfully made, clear the cart
      Provider.of<CartProvider>(context, listen: false).clearCart();

      //redirect the user to an informative page telling them that the order has been successfully created
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSuccessful(newOrder: newOrder, orderId: orderId,),
        ),
      );
    }

  }

  void updateSelectedAddress(ShippingAddress address) {
    setState(() {
      selectedShippingAddress = address;
    });
  }

  //method to update the payment method when the radio buttons are clicked
  void updatePaymentMethod(String paymentMethod){
    setState(() {
      selectedPaymentMethod = paymentMethod;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final accountProvider = Provider.of<AuthProvider>(context, listen: false);
    Account? account = accountProvider.getCurrentAccount();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: CheckoutShippingAddress(
                  account: account,
                  onAddressSelected: updateSelectedAddress,),
              ),
              CheckoutPaymentInformation(
                onPaymentMethodSelected: updatePaymentMethod,
              ),
            ]
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Items:',
                    ),
                    Text(
                      cartProvider.getSupplierItemsInCart(widget.account.id).length.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Price:',
                    ),
                    Text(
                      'KES ${cartProvider.getSupplierItemsTotalAmount(widget.account.id).toString()}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ]),
              TextButton(
                onPressed: () {
                  _createOrder(account!.id, widget.account.id, cartProvider.getSupplierItemsInCart(widget.account.id), cartProvider.getSupplierItemsTotalAmount(widget.account.id));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SUBMIT ORDER',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
