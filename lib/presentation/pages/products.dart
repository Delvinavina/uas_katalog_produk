import 'package:uas_katalog_produk/presentation/pages/about.dart';
import 'package:uas_katalog_produk/presentation/pages/cart_page.dart';
import 'package:uas_katalog_produk/presentation/pages/detail_page.dart';
import 'package:uas_katalog_produk/presentation/pages/login.dart';
import 'package:uas_katalog_produk/presentation/pages/settings.dart';
import 'package:uas_katalog_produk/presentation/provider/cart/bloc/cart_bloc.dart';
import 'package:uas_katalog_produk/presentation/provider/login/bloc/login_bloc.dart';
import 'package:uas_katalog_produk/presentation/provider/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'assets/carousel0.jpg',
      'assets/carousel1.jpg',
      'assets/carousel2.jpg',
      'assets/carousel3.jpg',
      'assets/carousel4.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Our products'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Badge.count(
                  count: state.items.length,
                  child: IconButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartPage(),
                          )),
                      icon: const Icon(Icons.shopping_cart)),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to home or perform any action
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('MyProfile'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserProfilePage(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                context.read<LoginBloc>().add(LogoutRequested());
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ImageSlideshow(
                  width: double.infinity,
                  height: 200,
                  children: imageList
                      .map(
                        (e) => Image.asset(e),
                      )
                      .toList(),
                ),
                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.asset(
                                  'assets/${state.products[index].imageAsset}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.products[index].name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                product: state.products[index]),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
