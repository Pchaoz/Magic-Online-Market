import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Util/globals.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product;

  const ProductDetailPage({super.key, this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List offerList = [];

  Future getOffers() async {
    final response = await http.get(Uri.parse(
        API_URI_LOCAL + "/ofertes/" + widget.product['idProducte'].toString()));
    print("El request a la ofertas del producto " +
        widget.product['idProducte'] +
        " ha sido: " +
        json.decode(response.body));

    if (response.statusCode == 200) {
      setState(() {
        offerList = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: Text(widget.product['nom']),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(widget.product['descripcio'],
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(25.0),
                child: Flexible(
                  child: Image.network(
                      '$URI_SERVER_IMAGES/${widget.product['imatge']}'),
                ),
              ),
              Text('Ofertas', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: offerList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(offerList[index]['nick']),
                        subtitle: Text(offerList[index]['quantitat']),
                        onTap: () {
                          //TODO hacer el tema de la compra y todo el rollo
                        });
                  },
                ),
              )
            ]),
      ),
    );
  }
}
