import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:magic_market_mobile/Views/News/newsPage.dart';

import '../../Util/globals.dart';
import 'barallesUserPage.dart';

class BarallaEditPage extends StatefulWidget {
  Map<String, dynamic> barallaInfo;

  BarallaEditPage({super.key, required this.barallaInfo});

  @override
  _BarallaEditPage createState() => _BarallaEditPage();
}

class _BarallaEditPage extends State<BarallaEditPage> {
  //VARIABLES
  String nomBaralla = '';
  bool isPublic = false;

  //FUNCIONES
  void updateBaralla() async {
    int idBaralla = widget.barallaInfo['idBaralla'];
    final response = await http.put(Uri.parse('$API_URI_SERVER/updateBaralla'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nom': nomBaralla,
          'idUser': userID,
          'public': isPublic ? 0 : 1,
          'idBaralla': idBaralla
        }));

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Baralla actualitzada correctament.'),
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
                'Error actualitzant la baralla. Codig de error: ${response.statusCode}'),
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

  void deleteBaralla() async {
    int idBaralla = widget.barallaInfo['idBaralla'];
    final response = await http.post(Uri.parse('$API_URI_SERVER/createBaralla'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'idBaralla': idBaralla,
        }));

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Baralla borrada correctament.'),
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
                'Error borrant la baralla. Codig de error: ${response.statusCode}'),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.barallaInfo['nomBaralla'],
                decoration: const InputDecoration(
                  labelText: 'Nom de la baralla',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el nombre de la baralla';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    nomBaralla = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('¿Es public?'),
                value: widget.barallaInfo['isPublic'] == 1,
                onChanged: (bool? value) {
                  setState(() {
                    isPublic = value!;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: updateBaralla,
                    child: const Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: deleteBaralla,
                    child: const Text('Borrar'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
