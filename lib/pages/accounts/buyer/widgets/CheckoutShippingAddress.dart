
import 'package:flutter/material.dart';

import '../../../../apis/AccountApi.dart';
import '../../../../models/Account.dart';
import '../../../../models/ShippingAddress.dart';
import '../../../../providers/user_provider.dart';
import 'package:provider/provider.dart';

class CheckoutShippingAddress extends StatefulWidget {
  CheckoutShippingAddress({super.key, required this.account});
  final Account? account;

  @override
  State<CheckoutShippingAddress> createState() => _CheckoutShippingAddressState();
}

class _CheckoutShippingAddressState extends State<CheckoutShippingAddress> {
  final GlobalKey<FormState> _shippingAddressFormKey = GlobalKey<FormState>();
  AccountApi _accountApi = new AccountApi();
  TextEditingController _addressController = new TextEditingController();

  TextEditingController _cityController = new TextEditingController();

  TextEditingController _countryController = new TextEditingController();

  TextEditingController _postalCodeController = new TextEditingController();

  bool _isAddingAddress = false;

  void clearInputFields(){
    _addressController.text = "";
    _cityController.text = "";
    _countryController.text = "";
    _postalCodeController.text = "";
  }
  void _addAddressInformation() async {
    //create ta new address object
    ShippingAddress _shippingAddress = new ShippingAddress(
      accountId: Provider.of<UserProvider>(context, listen: false).account!.id!,
      address: _addressController.text,
      city: _cityController.text,
      county: _countryController.text,
      postalCode: _postalCodeController.text
    );


    String? feedback = await _accountApi.addShippingAddress(_shippingAddress);
    if(feedback != null){
      _isAddingAddress = false;
      clearInputFields();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(feedback),
        duration: Duration(milliseconds: 300),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ));
    }
  }


  //fetching the shipping address for this given account
  late Future<ShippingAddress?> _shippingAddress;

  void _fetchShippingAddress() async {
    _shippingAddress = _accountApi.fetchAccountShippingAddress(Provider.of<UserProvider>(context, listen: false).account!.id!);
  }

  @override
  void initState(){
    _fetchShippingAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //retrieve the account's shipping address
    void _handleAddShippingAddress() async {
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
                            decoration: InputDecoration(
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              labelText: 'City',
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _countryController,
                            decoration: InputDecoration(
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
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _postalCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Postal Code',
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
                          SizedBox(height: 20),
                          Container(
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
                                SizedBox(width: 10),
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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Shipping Address',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
          padding:
              EdgeInsets.only(top: 0, bottom: 16.0, left: 16.0, right: 16.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                )
              ]),
          child: FutureBuilder<ShippingAddress?>(
            future: _shippingAddress,
            builder: (BuildContext context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Text('Something has gone wrong!');
              }else if(snapshot.data == null){
                return GestureDetector(
                  onTap: (){
                    _handleAddShippingAddress();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/question.png',
                          height: MediaQuery.of(context).size.height * 0.075,
                          width: MediaQuery.of(context).size.height * 0.075,),
                        SizedBox(height: 10),
                        Container(
                            width: 200,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Colors.black.withOpacity(0.2))
                            ),
                            child: Row(
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
                final shippingAddress = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(shippingAddress.address,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery.of(context).size.height * 0.02)),
                        TextButton(
                            onPressed: () {
                              print('Change the shipping address information');
                            },
                            child: Text('Change',
                                style: TextStyle(
                                    color: Colors.red.shade300,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                    //Text(shippingAddress.),
                    Text(
                        '${shippingAddress.city}, ${shippingAddress.county} - ${shippingAddress.postalCode}')
                  ],
                );
              }
          }
          )
      )
    ]);
  }
}
