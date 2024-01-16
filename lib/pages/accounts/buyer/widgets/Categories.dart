import 'package:connecta/apis/Product_Api.dart';
import 'package:connecta/components/cards/CategoryCard.dart';
import 'package:connecta/pages/accounts/buyer/pages/ShoppingCart.dart';
import 'package:connecta/pages/accounts/buyer/pages/notifications.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
    return FutureBuilder<List<String>>(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return const CircularProgressIndicator();
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
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: false,
              ), //FlexibleSpaceBar
              expandedHeight: 200,
              backgroundColor: Colors.blueGrey,
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                tooltip: 'Menu',
                onPressed: () {},
              ), //IconButton

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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: SliverGrid(
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
              ),
            )
          ]);
        }
      },
    );
  }
}
