import 'package:connecta/apis/Product_Api.dart';
import 'package:connecta/components/cards/CategoryCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ShoppingCart.dart';
import 'notifications.dart';
import 'package:badges/badges.dart' as badges;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<String>> _categories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    Product_Api productApi = Product_Api();
    // Use your fetchProducts() function to get the products
    _categories = productApi.fetchProductCategories();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurred, show an error message
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If no data is available, show a message
            return const Text('No categories available.');
          } else {
            // If the data is available, build the GridView
            return CustomScrollView(slivers: [
              SliverAppBar(
                snap: false,
                pinned: true,
                floating: false,
                expandedHeight: 100,
                backgroundColor: Colors.blueGrey,
                shadowColor: Colors.blue,
                automaticallyImplyLeading: false,
                actions: [
                  badges.Badge(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShoppingCart(),
                        ),
                      );
                    },
                    badgeContent: const Text(
                      "3",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                  ),
                  badges.Badge(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Notifications(),
                        ),
                      );
                    },
                    badgeContent:
                        const Text('3', style: TextStyle(color: Colors.white)),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 8, bottom: 0),
                  title: SizedBox(
                    height: 45,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          decorationThickness: 6,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CategoryCard(category: snapshot.data![index]);
                  },
                  childCount: snapshot.data!.length,
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}
