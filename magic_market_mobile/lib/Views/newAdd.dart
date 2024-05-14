import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Util/globals.dart';

import 'homePage.dart';

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
      Uri.parse("$API_URI_SERVER/APIuploadArticle"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(articleInfo),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      print('Artículo creado exitosamente');
    } else {
      print('Error al crear el artículo: ${response.statusCode}');
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
          // Agrega un Form aquí
          key: _formKey, // Asigna la clave global al Form
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
