import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Util/globals.dart';
import '../../Util/lateralMenu.dart';
import '../Profile/loginPage.dart';
import '../Wishlist/addToWishListPage.dart';
import '../homePage.dart';
import 'productsDetailsPage.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/getAllProductes'));
    setState(() {
      products = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: const Text('Magic Online Market'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 11, 214, 153),
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Productes',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, index) =>
                        const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPressStart: (details) {
                          _showPopupMenu(context, details.globalPosition,
                              products[index]['idProducte']);
                        },
                        child: ListTile(
                          leading: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: Image.network(
                              products[index]['imatge'] != null
                                  ? URI_SERVER_IMAGES +
                                      "/" +
                                      products[index]['imatge']
                                  : "$URI_SERVER_IMAGES/default.png",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          title: Text(products[index]['nom'] ?? ""),
                          subtitle:
                              Text(products[index]['nomCategoria'].toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailPage(product: products[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      drawer: LateralMenu(
        onTapLogout: () => _logOut(context),
      ),
    );
  }

  void _logOut(context) {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("ERROR.. $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to authenticate user'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showPopupMenu(BuildContext context, Offset position, int productId) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'wishlist',
          child: Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.black),
              SizedBox(width: 8),
              Text('Añadir a wishlist', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ).then((value) {
      if (value == 'wishlist') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddToWishListPage(
              productID: productId,
            ),
          ),
        );
      }
    });
  }
}
