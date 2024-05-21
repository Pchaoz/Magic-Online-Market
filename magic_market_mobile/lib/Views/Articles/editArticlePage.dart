import 'package:magic_market_mobile/Views/Articles/articlesUser.dart';
import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../Util/globals.dart';

class EditArticlePage extends StatefulWidget {
  Map<String, dynamic> article;

  EditArticlePage({super.key, required this.article});

  @override
  _EditArticlePage createState() => _EditArticlePage();
}

class _EditArticlePage extends State<EditArticlePage> {
  var idArticle = 0;
  var quantitat = 0;
  var preu = 0.0;

  @override
  void initState() {
    super.initState();
    print(widget.article.toString());
    idArticle = widget.article['idArticle'];
    quantitat = widget.article['quantitat'];
    preu = widget.article['preu'];
  }

  void updateArticle() async {
    final response = await http.put(Uri.parse('$API_URI_SERVER/updateArticle'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'quantitatDisponible': quantitat,
          'idUser': userID,
          'preuUnitari': preu,
          'idArticle': idArticle
        }));

    print("resultado update article:  ${response.statusCode}");

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Article actualitzat correctament.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ArticlesUser()),
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
                'Error actualitzant el article. Codig de error: ${response.statusCode}'),
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

  void deleteArticle() async {
    print("INTENTANT ELIMINAR EL ARTICLE AMB ID: $idArticle");

    final response = await http
        .delete(Uri.parse('$API_URI_SERVER/deleteArticle/$idArticle'));

    print("resultado borrar article:  ${response.statusCode}");
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit'),
            content: const Text('Article borrat correctament.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ArticlesUser()),
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
                'Error borrant el article. Codig de error: ${response.statusCode}'),
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
                initialValue: preu.toString(),
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
                onChanged: (value) {
                  setState(() {
                    preu = double.parse(value);
                  });
                },
              ),
              TextFormField(
                initialValue: quantitat.toString(),
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
                onChanged: (value) {
                  setState(() {
                    quantitat = int.parse(value);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: updateArticle,
                    child: const Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: deleteArticle,
                    child: const Text('Borrar'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
