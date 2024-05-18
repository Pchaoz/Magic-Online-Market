import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/newsDetailsPage.dart';
import 'dart:convert';

import '../Util/globals.dart';
import 'homePage.dart';

class BarallaDetailsPage extends StatefulWidget {
  final int barallaID;

  const BarallaDetailsPage({Key? key, required this.barallaID})
      : super(key: key);

  @override
  __BarallaDetailsPage createState() => __BarallaDetailsPage();
}

class __BarallaDetailsPage extends State<BarallaDetailsPage> {
  //VARIABLES

  //FUNCTIONS
  @override
  void initState() {
    super.initState();
    fetchDeck();
  }

  void fetchDeck() async {
    final response = await http
        .get(Uri.parse("$API_URI_SERVER/getBarallaByID/$widget.barallaID"));
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
    );
  }
}
