import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Util/globals.dart';
import '../Util/globals.dart';

class BarallesUser extends StatefulWidget {
  @override
  _BarallesUser createState() => _BarallesUser();
}

class _BarallesUser extends State<BarallesUser> {
  //FUNCIONES
  @override
  void initState() {
    super.initState();
    fetchMyDecks();
  }

  fetchMyDecks() async {
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/ofertesUsuari/$userID'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Magic Online Market",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Magic Online Market'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
                //TODO - pues eso que lo tengo que hacer
                )
          ],
        ),
      ),
    );
  }
}
