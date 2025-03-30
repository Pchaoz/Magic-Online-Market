import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_magic_market_mobile/Views/News/newsDetailsPage.dart';
import 'dart:convert';

import '../../Util/LateralMenu.dart';
import '../../Util/globals.dart';
import '../Profile/loginPage.dart';
import '../homePage.dart';

class NewsPage extends StatefulWidget {
  @override
  __NewsPageState createState() => __NewsPageState();
}

class __NewsPageState extends State<NewsPage> {
  List news = [];

  // Función para obtener las noticias del servidor
  Future fetchNews() async {
    final response = await http.get(Uri.parse('$API_URI_CASA/noticies'));

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
            width: double.infinity,
            child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Noticias',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsPage(info: news[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                URI_SERVER_IMAGES +
                                    news[index]['imatge'].toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          news[index]['titol'].toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text("created by ${news[index]['nick']}"),
                      ],
                    ),
                  ),
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
                child: const Text('Tancar'),
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
