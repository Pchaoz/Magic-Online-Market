import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:app_magic_market_mobile/Views/Articles/newAdd.dart';
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
  final TextEditingController _quantityController = TextEditingController();
  int? selectedOfferId;
  int? selectedQuantity;

  Future getOffers() async {
    print("Buscando las ofertas del producto: ${widget.product['idProducte']}");

    final response = await http.get(
        Uri.parse("$API_URI_CASA/ofertes/${widget.product['idProducte']}"));

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
      final response = await http.post(
        Uri.parse("$API_URI_CASA/cart/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'productId': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Producto añadido al carrito'),
            ),
          );
        });
      } else {
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error al añadir el producto al carrito'),
            ),
          );
        });
      }
    } catch (e) {
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
    final scaffoldContext = context; // Guardar el contexto del Scaffold
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar cantidad'),
          content: SingleChildScrollView(
            // Para evitar el overflow
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Cantidad',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
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
                  if (quantity <= 0 ||
                      quantity > offerList[index]['quantitat']) {
                    Navigator.of(context).pop(); // Cerrar el diálogo primero

                    // Mostrar el SnackBar después de cerrar el diálogo
                    Future.delayed(Duration(milliseconds: 100), () {
                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                        const SnackBar(
                          content: Text('Error, valor incorrecto de compra'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    });
                  } else {
                    setState(() {
                      selectedOfferId = offerList[index]['id'];
                      selectedQuantity = quantity;
                    });
                    Navigator.of(context).pop();
                    _showCartOptionsDialog();
                  }
                } catch (e) {
                  Navigator.of(context).pop(); // Cerrar el diálogo primero

                  // Mostrar el SnackBar después de cerrar el diálogo
                  Future.delayed(Duration(milliseconds: 100), () {
                    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                      const SnackBar(
                        content: Text('Ingrese una cantidad válida'),
                        duration: Duration(seconds: 3),
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ir al menú principal'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
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
