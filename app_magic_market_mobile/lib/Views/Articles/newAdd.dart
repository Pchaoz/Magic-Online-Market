import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:app_magic_market_mobile/Util/globals.dart';

import '../Products/productsPage.dart';
import '../homePage.dart';

class NewAddPage extends StatefulWidget {
  final dynamic product;

  const NewAddPage({this.product});

  @override
  _NewAddPageState createState() => _NewAddPageState();
}

class _NewAddPageState extends State<NewAddPage> {
  final _formKey =
      GlobalKey<FormState>(); // Agrega una clave global para el Form
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Map<String, dynamic> articleInfo = {};

  Future<void> uploadArticle() async {
    articleInfo['idProducte'] = widget.product['idProducte'];
    articleInfo['idUser'] = userID;

    print("INTENTANDO CREAR: $articleInfo");

    final response = await http.post(
      Uri.parse("$API_URI_CASA/uploadArticle"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(articleInfo),
    );

    if (response.statusCode == 200) {
      print('Artículo creado exitosamente');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit!'),
          content: const Text('Article creat amb exit.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsPage()),
                );
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text(
                      'Error al crear el article: ${response.statusCode}')),
              Center(child: Text('${jsonDecode(response.body)['message']}')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Preu per unitat'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sisuplau introdueix un numero';
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Sisuplau introdueix un numero';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Quantitat'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sisuplau introdueix un numero sencer';
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return 'Sisuplau introdueix un numero sencer';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        articleInfo['quantitatDisponible'] =
                            priceController.text;
                        articleInfo['preuUnitari'] = amountController.text;
                        uploadArticle();
                      }
                    },
                    child: const Text('Crear'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
