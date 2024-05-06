import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Util/LateralMenu.dart';
import '../Util/globals.dart';
import 'loginPage.dart';

class NewsPage extends StatefulWidget {
  @override
  __NewsPageState createState() => __NewsPageState();
}

class __NewsPageState extends State<NewsPage> {
  List news = [];

  // Función para obtener las cartas del servidor
  Future fetchNews() async {
    final response = await http.get(Uri.parse('$API_URI_LOCAL/api/noticies/'));
    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
      ),
      body: Column(),
      drawer: LateralMenu(
        onTapLogout: () => _LogOut(context),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void _LogOut(context) {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("ERROR.. $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to authenticate user'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
