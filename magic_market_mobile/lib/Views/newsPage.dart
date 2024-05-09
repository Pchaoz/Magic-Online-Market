import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/newsDetailsPage.dart';
import 'dart:convert';

import '../Util/LateralMenu.dart';
import '../Util/globals.dart';
import 'homePage.dart';
import 'loginPage.dart';

class NewsPage extends StatefulWidget {
  @override
  __NewsPageState createState() => __NewsPageState();
}

class __NewsPageState extends State<NewsPage> {
  List news = [];

  // Función para obtener las noticias del servidor
  Future fetchNews() async {
    final response = await http.get(Uri.parse('$API_URI_SERVER/noticies'));

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
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 11, 214, 153),
            width: double
                .infinity, // Asegura que el contenedor ocupe todo el ancho
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Noticias',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: news.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50, // Define the width of the image
                    height: 50, // Define the height of the image
                    child: Image.network(
                      URI_SERVER_IMAGES + news[index]['imatge'].toString(),
                      fit: BoxFit
                          .cover, // Use BoxFit.cover to maintain the aspect ratio of the image
                    ),
                  ),
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
          )
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
