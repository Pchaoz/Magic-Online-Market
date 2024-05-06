import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Util/globals.dart';
import 'homePage.dart';

class NewsDetailsPage extends StatefulWidget {
  final Map<String, dynamic> info;

  const NewsDetailsPage({Key? key, required this.info}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  late Future<List<dynamic>> _newsData;

  @override
  void initState() {
    super.initState();
    _newsData = _fetchNewsData();

    //Si, se que estoy haciendo un Foreach para un item lo siento
    _newsData.then((list) {
      for (var item in list) {
        var contingut = item['contingut'];
        if (contingut != null) {
          item['contingut'] = contingut.replaceAll(RegExp(r'\s+'), ' ');
        }
      }
    });
  }

  Future<List<dynamic>> _fetchNewsData() async {
    final response = await http
        .get(Uri.parse("$API_URI_SERVER/noticies/${widget.info['idNoticia']}"));

    print("STATUS CODE IS: ${response.statusCode}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news data');
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
      body: FutureBuilder<List<dynamic>>(
        future: _newsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final news = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Cambia aquí
                children: [
                  Text(news[0]['titol'],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text(news[0]['subtitol'],
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Image.network(
                      "$URI_SERVER_IMAGES/${news[0]['imatge']}",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(news[0]['contingut'],
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(news[0]['nick']),
                      Text(news[0]['dataHora'].toString()),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
