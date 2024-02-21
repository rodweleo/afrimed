import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class BusinessDocumentation extends StatefulWidget {
  const BusinessDocumentation({super.key});

  @override
  State<BusinessDocumentation> createState() => _BusinessDocumentationState();
}

class _BusinessDocumentationState extends State<BusinessDocumentation> {
  String selectedOption = "";

  //file picker for the national id
  FilePickerResult? nationalIds;

  File? selectedNationalIdDocuments;

  //file picker for the pharmaceutical documents
  FilePickerResult? pharmaceuticalDocuments;

  File? selectedPharmaceuticalDocument;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Business Documentation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Do you have relevant valid certificates and licenses?'),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Yes',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = "Yes";
                        });
                      },
                    ),
                    const Text('Yes')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'I will upload later',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = "I will upload later";
                        });
                      },
                    ),
                    const Text('I will upload later')
                  ],
                ),
              ],
            )
          ],
        ),
        if (selectedOption == 'Yes')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("National Id"),
              GestureDetector(
                onTap: () async {
                  nationalIds =
                      await FilePicker.platform.pickFiles(allowMultiple: true);

                  // Check if files were picked
                  if (nationalIds?.files.isNotEmpty ?? false) {
                    // Display the first selected file
                    final file = nationalIds!.files.first;
                    setState(() {
                      // Set the selected file to a variable to be used in the UI
                      selectedNationalIdDocuments =
                          file.path != null ? File(file.path!) : null;
                    });
                  }
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload Document',
                        style: TextStyle(color: Colors.black.withOpacity(0.4)),
                      ),
                      const Icon(Icons.file_upload, color: Colors.blueGrey)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (selectedNationalIdDocuments != null)
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1),
                    ),
                    child: Image.file(
                      selectedNationalIdDocuments!,
                      fit: BoxFit.fill,
                    )),
              const SizedBox(
                height: 20,
              ),
              const Text("Pharmaceutical Licence"),
              GestureDetector(
                onTap: () async {
                  pharmaceuticalDocuments =
                      await FilePicker.platform.pickFiles(allowMultiple: true);

                  // Check if files were picked
                  if (pharmaceuticalDocuments?.files.isNotEmpty ?? false) {
                    // Display the first selected file
                    final file = pharmaceuticalDocuments!.files.first;
                    setState(() {
                      // Set the selected file to a variable to be used in the UI
                      selectedPharmaceuticalDocument =
                          file.path != null ? File(file.path!) : null;
                    });
                  }
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload Document',
                        style: TextStyle(color: Colors.black.withOpacity(0.4)),
                      ),
                      const Icon(Icons.file_upload, color: Colors.blueGrey)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (selectedPharmaceuticalDocument != null)
                Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                    child: Image.file(
                      selectedPharmaceuticalDocument!,
                      fit: BoxFit.fill,
                    )),
            ],
          ),
      ],
    );
  }
}
