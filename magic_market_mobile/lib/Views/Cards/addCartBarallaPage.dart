import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/News/newsDetailsPage.dart';
import 'dart:convert';

import '../../Util/globals.dart';
import '../Baralles/barallesUserPage.dart';
import '../homePage.dart';

class AddCardBarallaPage extends StatefulWidget {
  final int barallaID;

  const AddCardBarallaPage({Key? key, required this.barallaID})
      : super(key: key);

  @override
  _AddCardBarallaPage createState() => _AddCardBarallaPage();
}

class Carta {
  final int idCarta;
  final String nom;

  Carta({required this.idCarta, required this.nom});

  factory Carta.fromJson(Map<String, dynamic> json) {
    return Carta(
      idCarta: json['idCarta'],
      nom: json['nom'],
    );
  }
}

class _AddCardBarallaPage extends State<AddCardBarallaPage> {
  //VARIABLES
  List<dynamic> cards = [];
  List<Carta> cartas = [];
  final _formKey = GlobalKey<FormState>();
  Carta? cartaSeleccionada;
  int? idCartaSeleccionada;
  var quantitat = 0;

  @override
  void initState() {
    super.initState();
    fetchAllCards();
  }

  fetchAllCards() async {
    final response = await http.get(Uri.parse('$API_URI_SERVER/getAllCartes'));

    print("STATUSCODE FETCH CARDS: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        cards = json.decode(response.body);
      });

      cartas = (cards).map((data) => Carta.fromJson(data)).toList();
    }
  }

  uploadCards() async {
    final response = await http.put(
      Uri.parse('$API_URI_SERVER/addCartBaralla'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'idUsuari': userID,
        'idCarta': idCartaSeleccionada,
        'idBaralla': widget.barallaID,
      }),
    );
    print("STATUSCODE UPLOADCARDS: ${response.statusCode}");

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Carta agregada correctament.'),
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo no puede estar vacío';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, introduce un número entero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      quantitat = int.parse(value);
                    }
                  },
                ),
              ),
              DropdownButton<Carta>(
                hint: const Text('Selecciona una carta'),
                value: cartaSeleccionada,
                items: cartas.map((Carta carta) {
                  return DropdownMenuItem<Carta>(
                    value: carta,
                    child: Text(carta.nom),
                  );
                }).toList(),
                onChanged: (Carta? nuevaCartaSeleccionada) {
                  setState(() {
                    cartaSeleccionada = nuevaCartaSeleccionada;
                    idCartaSeleccionada = nuevaCartaSeleccionada?.idCarta;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    uploadCards();
                  }
                },
                child: const Text('Crear'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
