import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/Baralles/barallesUserPage.dart';
import 'package:magic_market_mobile/Views/homePage.dart';

import '../../Util/globals.dart';
import '../homePage.dart';

class NewBarallaPage extends StatefulWidget {
  @override
  _NewBarallaPage createState() => _NewBarallaPage();
}

class _NewBarallaPage extends State<NewBarallaPage> {
  //VARIABLES
  final _formKey = GlobalKey<FormState>();
  String deckName = "";
  bool isPublic = false;

  //FUNCTIONS
  void createBaralla() async {
    print("SENDED THINGS CHECK FOR NEW DECKS: $deckName, $userID, $isPublic");

    final response = await http.post(Uri.parse('$API_URI_SERVER/createBaralla'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'deckName': deckName,
          'idUser': userID,
          'isPublic': isPublic ? 0 : 1
        }));

    print("STATUSCODE NEW DECK: ${response.statusCode}");

    print(jsonDecode(response.body).toString());

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Baralla creada correctament.'),
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
                'Error creant la baralla. Codig de error: ${response.statusCode}'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
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
                  decoration: InputDecoration(labelText: 'Nom de la baralla'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo no puede estar vacío';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      deckName = value;
                    }
                  },
                ),
              ),
              CheckboxListTile(
                title: Text('¿Es public?'),
                value: isPublic,
                onChanged: (bool? value) {
                  setState(() {
                    isPublic = value ?? false;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    createBaralla();
                  }
                },
                child: Text('Crear'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
