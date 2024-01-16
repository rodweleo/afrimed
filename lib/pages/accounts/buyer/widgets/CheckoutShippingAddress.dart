
import 'package:connecta/pages/accounts/buyer/widgets/account_shipping_address.dart';
import 'package:flutter/material.dart';

import '../../../../apis/AccountApi.dart';
import '../../../../models/Account.dart';
import '../../../../models/ShippingAddress.dart';
import '../../../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class CheckoutShippingAddress extends StatefulWidget {

  const CheckoutShippingAddress({super.key, required this.account, required this.onAddressSelected});
  final Account? account;

  final Function(ShippingAddress selectedAddress) onAddressSelected;
  @override
  State<CheckoutShippingAddress> createState() => _CheckoutShippingAddressState();
}

class _CheckoutShippingAddressState extends State<CheckoutShippingAddress> {
  final GlobalKey<FormState> _shippingAddressFormKey = GlobalKey<FormState>();
  final AccountApi _accountApi = AccountApi();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _townController = TextEditingController();

  final TextEditingController _countyController = TextEditingController();


  bool _isAddingAddress = false;

  void clearInputFields(){
    _addressController.text = "";
    _townController.text = "";
    _countyController.text = "";
  }
  void _addAddressInformation() async {
    //create ta new address object
    ShippingAddress shippingAddress = ShippingAddress(
      address: _addressController.text,
      town: _townController.text,
      county: _countyController.text,
    );


    String? feedback = await _accountApi.addShippingAddress(Provider.of<UserProvider>(context, listen: false).account!.id!, shippingAddress);
    if(feedback != null){
      _isAddingAddress = false;
      clearInputFields();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(feedback),
        duration: const Duration(milliseconds: 300),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ));
    }
  }


  //fetching the shipping address for this given account
  late Future<List<ShippingAddress>?> _shippingAddress;

  void _fetchShippingAddress() async {
    _shippingAddress = _accountApi.fetchAccountShippingAddress(Provider.of<UserProvider>(context, listen: false).account!.id!);
  }


  @override
  void initState(){
    _fetchShippingAddress();
    super.initState();
  }

  ShippingAddress? selectedAddress;
  void selectShippingAddress(ShippingAddress shippingAddress){
    setState((){
      selectedAddress = shippingAddress;
    });

    widget.onAddressSelected(selectedAddress!);
  }

  @override
  Widget build(BuildContext context) {
    //retrieve the account's shipping address
    void handleAddShippingAddress() async {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context){
            return AlertDialog(
                title: Text('Add Shipping Address', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045)),
                content: SingleChildScrollView(
                  child: Form(
                    key: _shippingAddressFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _addressController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black)
                              ),
                            ),
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the product name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _townController,
                            decoration: const InputDecoration(
                              labelText: 'Town',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black)
                              ),
                            ),
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the product name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _countyController,
                            decoration: const InputDecoration(
                              labelText: 'County',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black)
                              ),
                            ),
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the product name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black.withOpacity(0.1),
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5)))),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5)))),
                                    onPressed: () async {
                                      if (_shippingAddressFormKey.currentState!.validate()) {
                                        _addAddressInformation();
                                      }
                                    },
                                    child: _isAddingAddress
                                        ? const CircularProgressIndicator()
                                        : const Text('Add Address'),
                                  ),
                                )
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            );
          }
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      const Text(
        'Shipping Address',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      FutureBuilder<List<ShippingAddress>?>(
        future: _shippingAddress,
        builder: (BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(snapshot.hasError){
            return const Text('Something has gone wrong!');
          }else if(snapshot.data == null){
            return GestureDetector(
              onTap: (){
                handleAddShippingAddress();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/question.png',
                      height: MediaQuery.of(context).size.height * 0.075,
                      width: MediaQuery.of(context).size.height * 0.075,),
                    const SizedBox(height: 10),
                    Container(
                        width: 200,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.black.withOpacity(0.2))
                        ),
                        child: const Row(
                            children: [
                              Icon(Icons.add),
                              Text('Add Shipping Address')
                            ]
                        )

                    ),
                  ],
                ),
              ),
            );
          }else {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, int index){
                      return Container(
                        margin: const EdgeInsets.only(top: 7.5),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1.0,
                              blurRadius: 2.0
                            )
                          ]
                        ),
                        child: Row(
                          children: [
                            Radio(value: snapshot.data![index], groupValue: selectedAddress, onChanged: (value){
                              selectShippingAddress(snapshot.data![index]);
                            }),
                            AccountShippingAddress(shippingAddress: snapshot.data![index])
                          ],
                        ),
                      );
                    }),
              ),
            );
          }
      }
      )
    ]);
  }
}
