import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/newsDetailsPage.dart';
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

  // Función para obtener las noticias del servidor
  Future fetchNews() async {
    final response = await http.get(Uri.parse('$API_URI_LOCAL/noticies'));

    print("LA RESPUESTA DEL SERVIDOR ES: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(news[index]['titol'].toString()),
                  subtitle: Text("created by ${news[index]['nick']}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsPage(info: news[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: LateralMenu(
        onTapLogout: () => _logOut(context),
      ),
    );
  }

  void _logOut(context) {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("ERROR: $e");
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
