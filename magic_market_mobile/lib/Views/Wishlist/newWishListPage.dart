import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/Wishlist/WishListPage.dart';

import '../../Util/globals.dart';
import '../homePage.dart';

void main() {
  runApp(NewWishListPage());
}

class NewWishListPage extends StatefulWidget {
  @override
  _NewWishListPage createState() => _NewWishListPage();
}

class _NewWishListPage extends State<NewWishListPage> {
  //VARIABLES
  final _formKey = GlobalKey<FormState>();
  var wishlistName = "";

  //FUNCIONES
  @override
  void initState() {
    super.initState();
  }

  void createNewWishList() async {
    final response = await http.post(Uri.parse('$API_URI_SERVER/createBaralla'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': wishlistName,
          'idUser': userID,
        }));

    print("STATUSCODE NEW WISHLIST: ${response.statusCode}");

    if (response.statusCode == 200) {
      //MENSAJE CONGRATS SE HA CREAO 🤞
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Exit!'),
            content: const Text('WishList creada amb exit!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WishListsPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else if (response.statusCode == 400) {
      //MENSAJE ERROR CONTROLADO POR MI HEHE
      print(json.decode(response.body)["message"]);
      var error = json.decode(response.body)["message"];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Error creant la wishlist. Error: $error'),
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
    } else {
      //MENSAJE CAGADA ALGO HAY MAL
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                'Error creant la wishlist. Codig de error: ${response.statusCode}'),
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
                  decoration:
                      const InputDecoration(labelText: 'Nom de la Wishlist'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El campo no puede estar vacío';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      wishlistName = value;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      createNewWishList();
                    }
                  },
                  child: const Text('Crear'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
