import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:surplus/utils/product.dart';
import 'package:surplus/widgets/navbar.dart';
import 'package:surplus/widgets/prod_description.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  List cartItems = [];
  bool isVisible = true;
  List productsList = [];
  bool isLoading = false;

  fetchProduct() async {
    var url = 'https://fakestoreapi.com/products';
    var snapshot = await get(Uri.parse(url));
    if (snapshot.statusCode == 200) {
      var items = json.decode(snapshot.body);
      setState(() {
        productsList = items;
      });
    } else {
      setState(() {
        productsList = [];
      });
    }
  }

  void viewProduct(int id, int quantity) {
    final newItem = Product(
        id: productsList[id]['id'],
        price: (productsList[id]['price']).toDouble(),
        title: productsList[id]['title'],
        image: productsList[id]['image'],
        quantity: quantity);
    setState(() {
      cartItems.add(newItem);
    });
  }

  void toggleButton() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void _productDescription(BuildContext context, index) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (buildContext) {
        return GestureDetector(
          onTap: () {},
          child: ProductDescription(viewProduct, productsList[index]),
          behavior: HitTestBehavior.translucent,
        );
      },
    );
  }

  circularProgress() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Surplus'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed( context, '/cart', arguments: {'items': cartItems});
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 25,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[700],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: productsList.length,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(productsList[index]['image']),
                              ),
                              height: 120,
                              width: 1000,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Text(
                            '\$${productsList[index]['price']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber
                            ),
                          ),
                          Text(
                            'In Stock',
                            style: TextStyle(
                                fontSize: 6,
                                color: Colors.black
                            ),
                          ),
                          Container(
                            child: Center(
                              child: RaisedButton.icon(
                                color: Colors.amberAccent,
                                onPressed: () {
                                  _productDescription(context, index);
                                },
                                icon: Icon(
                                  Icons.checkroom,
                                  size: 15,
                                ),
                                label: Text('View'),
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 220,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          )
        ],
      ),
    );
  }
}