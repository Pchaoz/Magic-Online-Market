import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/Articles/newAdd.dart';
import 'dart:convert';

import '../../Util/globals.dart';
import '../Profile/loginPage.dart';
import '../homePage.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product;

  const ProductDetailPage({super.key, this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var ButtonAdd;
  List offerList = [];

  Future getOffers() async {
    print("Buscando las ofertas del producto: ${widget.product['idProducte']}");

    final response = await http.get(
        Uri.parse("$API_URI_SERVER/ofertes/${widget.product['idProducte']}"));

    print("STATUS CODE IS: ${response.statusCode}");
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
    loadRolePreferences();
  }

  void loadRolePreferences() {
    if (roleID == 1 || roleID == 2 || roleID == 4 || roleID == 5) {
      print("SOY ADMIN O TIENDA");
      ButtonAdd = FloatingActionButton(
        onPressed: () {
          //REDIRECT FORM OFERTA
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NewAddPage(
                      product: widget.product,
                    )),
          );
        },
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        child: const Icon(Icons.add),
      );
    } else {
      ButtonAdd = null;
    }
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
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                child: Text(widget.product['descripcio'],
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(25.0),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.product['imatge'] != null
                          ? URI_SERVER_IMAGES + "/" + widget.product['imatge']
                          : "$URI_SERVER_IMAGES/default.png",
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Text('Articles', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: offerList.length,
                  separatorBuilder: (context, index) =>
                      const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(offerList[index]['nick']),
                        subtitle:
                            Text(offerList[index]['quantitat'].toString()),
                        trailing: Text("${offerList[index]['preu']}€"),
                        onTap: () {
                          if (roleID == 0) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      "Has d'inciar sessio per a comprar.. "),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Iniciar sessio'),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      },
                                    ),
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
                          } else {
                            if (userID != offerList[index]['idVenedor']) {
                              //TEMA DE LA COMPRA
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'No pots comprar la carta que has ofertat.. carta.. '),
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
                        });
                  },
                ),
              )
            ]),
      ),
      floatingActionButton: ButtonAdd,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
