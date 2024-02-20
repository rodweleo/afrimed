import 'package:flutter/material.dart';

class AboutAfrimed extends StatelessWidget {
  const AboutAfrimed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: [
          IconButton(
              onPressed: () {
                //share the app with other people
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
                "AfriMed is a revolutionary platform designed to streamline the supply chain process for medical manufacturers, suppliers, and buyers across Africa. With a mission to bridge the gap between manufacturers, suppliers, and buyers, AfriMed aims to revolutionize the way medicine is distributed and accessed throughout the continent.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.0175)),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Key Features:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.02),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "\u2022 Efficient Supply Chain Management:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "AfriMed offers a robust supply chain management system, enabling seamless coordination between medical manufacturers, suppliers, and buyers. This ensures timely delivery of essential medicines to end-users."),
            ),
            const Text(
              "\u2022 Comprehensive Database:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Our platform hosts an extensive database of medical products from trusted manufacturers, providing buyers with access to a wide range of pharmaceuticals and medical supplies."),
            ),
            const Text(
              "\u2022 Real-Time Updates:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Stay informed with real-time updates on product availability, pricing, and delivery schedules. AfriMed keeps all stakeholders in the loop, minimizing delays and disruptions in the supply chain."),
            )
          ],
        ),
      ),
    );
  }
}
