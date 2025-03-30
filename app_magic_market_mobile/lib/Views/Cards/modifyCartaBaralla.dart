import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_magic_market_mobile/Views/Baralles/barallaDetailsPage.dart';
import 'dart:convert';

import '../../Util/globals.dart';
import '../Baralles/barallesUserPage.dart';
import '../homePage.dart';

class ModifyCartaBarallaPage extends StatefulWidget {
  final List<dynamic> cardInfo;
  int quantity;
  int idBaralla;

  ModifyCartaBarallaPage(
      {super.key,
      required this.cardInfo,
      required this.quantity,
      required this.idBaralla});

  @override
  _ModifyCartaBarallaPage createState() => _ModifyCartaBarallaPage();
}

class _ModifyCartaBarallaPage extends State<ModifyCartaBarallaPage> {
  //Variables
  final _formKey = GlobalKey<FormState>();
  var idCarta;

  //Funciones
  @override
  void initState() {
    super.initState();
    idCarta = widget.cardInfo[0]['idCarta'];
    print(widget.idBaralla);
    //print(widget.cardInfo.toString());
    //print(widget.quantity.toString());
  }

  modifyCardFromBaralla() async {
    final response = await http.put(
      Uri.parse('$API_URI_CASA/updateCartaBaralla'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userID': userID,
        'idCarta': idCarta,
        'idBaralla': widget.idBaralla,
        'quantitat': widget.quantity
      }),
    );

    print("MODIFICAR CARTA FROM BARALLA STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Carta actualitzada correctament'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarallaDetailsPage(
                              barallaID: widget.idBaralla,
                            )),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                'Error agregant la carta. Codig de error ${response.statusCode}'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarallesUser()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  deleteCardFromBaralla() async {
    final response = await http.delete(
      Uri.parse('$API_URI_CASA/deleteCartaBatalla'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'idCarta': idCarta, 'idBaralla': widget.idBaralla}),
    );

    print("ELIMINAR CARTA FROM BARALLA STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Carta eliminada correctament'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarallesUser()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                'Error eliminant la carta. Codig de error ${response.statusCode}'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BarallesUser()),
                  );
                },
              ),
            ],
          );
        },
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
      body: SingleChildScrollView(
        // Agrega SingleChildScrollView
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    initialValue: widget.quantity.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Quantitat'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El camp no pot estar buit';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Siusplau introdueix un numero sencer';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        widget.quantity = int.parse(value);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Image.network(
                      "$URI_SERVER_IMAGES/${widget.cardInfo[0]['imatge']}",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      modifyCardFromBaralla();
                    }
                  },
                  child: const Text('Guardar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      deleteCardFromBaralla();
                    }
                  },
                  child: const Text('Eliminar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
