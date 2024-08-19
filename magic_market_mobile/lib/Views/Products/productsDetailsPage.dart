import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/Articles/newAdd.dart';
import 'dart:convert';

import '../../Util/globals.dart';
import '../Profile/loginPage.dart';
import '../homePage.dart';
import 'productsPage.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product;

  const ProductDetailPage({super.key, this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var ButtonAdd;
  List offerList = [];
  final TextEditingController _quantityController = TextEditingController();

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

  Future<void> afegirCistellDeCompra(int productId, int quantity) async {
    try {
      // Aquí realizarías la petición asíncrona al servidor para añadir el producto al carrito
      final response = await http.post(
        Uri.parse("$API_URI_SERVER/cart/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve un OK, actualiza el estado de la aplicación
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Producto añadido al carrito'),
            ),
          );
        });
      } else {
        // Si la petición falla, muestra un mensaje de error
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al añadir el producto al carrito'),
            ),
          );
        });
      }
    } catch (e) {
      // Manejo de cualquier otra excepción
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      });
    }
  }

  void _showQuantityDialog(int index) {
    _quantityController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar cantidad'),
          content: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Cantidad',
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                try {
                  int quantity = int.parse(_quantityController.text);
                  print("QUIERES COMPRAR: $quantity");
                  print(
                      "LA OFERTA ESTA OFERTANDO: ${offerList[index]['quantitat']}");
                  if (quantity <= 0 ||
                      quantity > offerList[index]['quantitat']) {
                    Navigator.of(context).pop();
                    Future.delayed(Duration.zero, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cantidad no válida'),
                        ),
                      );
                    });
                  } else {
                    afegirCistellDeCompra(offerList[index]['id'], quantity);
                    Navigator.of(context).pop();
                    _showCartOptionsDialog();
                  }
                } catch (e) {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ingrese una cantidad válida'),
                      ),
                    );
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showCartOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Producto añadido'),
          content:
              const Text('¿Deseas seguir comprando o ir al carrito de compra?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Seguir comprando'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage()),
                );
              },
            ),
            TextButton(
              child: const Text('Ir al carrito'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage()),
                );
              },
            ),
          ],
        );
      },
    );
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
                            Future.delayed(Duration.zero, () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Has de iniciar sesión para comprar.'),
                                  action: SnackBarAction(
                                    label: 'Iniciar sesión',
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                  ),
                                ),
                              );
                            });
                          } else {
                            if (userID != offerList[index]['idVenedor']) {
                              _showQuantityDialog(index);
                            } else {
                              Future.delayed(Duration.zero, () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No puedes comprar tu propia oferta.'),
                                  ),
                                );
                              });
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
