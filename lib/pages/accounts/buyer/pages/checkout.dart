import 'package:AfriMed/components/success_page/OrderSuccessful.dart';
import 'package:AfriMed/pages/accounts/buyer/functions/groupCartItems.dart';
import 'package:AfriMed/pages/accounts/buyer/widgets/CheckoutPaymentInformation.dart';
import 'package:AfriMed/pages/accounts/buyer/widgets/CheckoutShippingAddress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AfriMed/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../../apis/Order_Api.dart';
import '../../../../models/Account.dart';
import '../../../../models/CartItem.dart';
import 'package:AfriMed/providers/cart_provider.dart';
import '../../../../models/ShippingAddress.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  ShippingAddress? selectedShippingAddress;
  void _createOrder() async {
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

    //in cases where the products have different suppliers,
    //we need to group the products per supplier then send the order
    Map<String, List<CartItem>> modifiedCartItems = groupCartItems(
        Provider.of<CartProvider>(context, listen: false).cartItems);

    Order_Api orderApi = Order_Api();

    String? feedback = await orderApi.createOrder(
        Provider.of<UserProvider>(context, listen: false).account!.id!,
        modifiedCartItems,
        selectedShippingAddress,
        context);

    if(feedback != null){
      //clear the cart provider
      //Provider.of<CartProvider>(context, listen: false).clearCart();
      Navigator.of(context).pop();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderSuccessful(),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Something went wrong.'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: (){
                _createOrder();
              },
            ),
        )
      );
    }




  }

  void updateSelectedAddress(ShippingAddress address) {
    setState(() {
      selectedShippingAddress = address;
    });

    print(selectedShippingAddress);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final accountProvider = Provider.of<UserProvider>(context);
    Account? account = accountProvider.account;
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: const CheckoutPaymentInformation(),
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
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Items:',
                    ),
                    Text(
                      cartProvider.getTotalAmount().toString(),
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
                      'KSh ${cartProvider.getTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ]),
              TextButton(
                onPressed: () {
                  _createOrder();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
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
