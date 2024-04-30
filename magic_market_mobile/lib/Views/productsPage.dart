import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Util/LateralMenu.dart';
import '../Util/globals.dart';
import 'loginPage.dart';

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
        title: Text('Productos'),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(
                  URI_SERVER_IMAGES + "/" + products[index]['imatge']),
              title: Text(products[index]['nom']),
              subtitle: Text(products[index]['idCategoriaProducte'].toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: products[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
      drawer: LateralMenu(
        onTapLogout: () => _LogOut(context),
      ),
    );
  }

  void _LogOut(context) {
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
                child: const Text('Close'),
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
}

class ProductDetailPage extends StatefulWidget {
  final dynamic product;

  ProductDetailPage({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<List<dynamic>> futureOffers;

  @override
  void initState() {
    super.initState();
    futureOffers = fetchOffers();
  }

  Future<List<dynamic>> fetchOffers() async {
    final response =
        await http.get(Uri.parse(API_URI_LOCAL + widget.product['idArticulo']));
    print("RESPUESTA DEL SERVIDOR: " + response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load offers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.product['nom'])), // Título centrado
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureOffers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['nick']),
                  subtitle: Text('Precio: ${snapshot.data![index]['precio']}€'),
                  onTap: () {
                    // Aquí puedes definir qué sucede cuando se hace clic en un elemento de la lista
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
