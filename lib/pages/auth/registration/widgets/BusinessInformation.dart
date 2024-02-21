import 'package:flutter/material.dart';

class BusinessInformation extends StatefulWidget {
  const BusinessInformation({
    super.key,
    required this.businessNameController,
    required this.addressController,
    required this.townController,
    required this.countyController,
  });

  final TextEditingController businessNameController;
  final TextEditingController addressController;
  final TextEditingController townController;
  final TextEditingController countyController;

  @override
  State<BusinessInformation> createState() => _BusinessInformationState();
}

class _BusinessInformationState extends State<BusinessInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Business Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: widget.businessNameController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Business Name:',
            ),
          ),
        ),
        //some space between name and email
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: widget.addressController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Address',
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: widget.townController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Town',
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: widget.countyController,
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'County',
            ),
          ),
        ),
      ],
    );
  }
}
