import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/newsDetailsPage.dart';
import 'dart:convert';

import 'homePage.dart';

class BarallaDetailsPage extends StatefulWidget {
  final List<dynamic> baralla;

  const BarallaDetailsPage({Key? key, required this.baralla}) : super(key: key);

  @override
  __BarallaDetailsPage createState() => __BarallaDetailsPage();
}

class __BarallaDetailsPage extends State<BarallaDetailsPage> {
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
