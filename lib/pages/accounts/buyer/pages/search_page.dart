import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              // Add a clear button to the search bar
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
                onPressed: () => searchController.clear(),
              ),
              // Add a search icon or button to the search bar
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Perform the search here
                },
              ),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Search",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    //clear the search history
                  },
                  child: const Text('Clear'))
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text("Scroll View Example"),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.clear)),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text("Scroll View Example"),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.clear)),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text("Scroll View Example"),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.clear)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
