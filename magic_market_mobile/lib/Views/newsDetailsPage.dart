import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Util/globals.dart';

class NewsDetailsPage extends StatefulWidget {
  final dynamic info;

  const NewsDetailsPage({Key? key, required this.info}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  late Map<String, dynamic> news;

  Future<void> getNotice() async {
    print("Buscando la noticia con la id: ${widget.info['idNoticia']}");

    final response = await http.get(
      Uri.parse("$API_URI_LOCAL/noticies/${widget.info['idNoticia']}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = json.decode(response.body);
      if (decodedList.isNotEmpty) {
        setState(() {
          news = decodedList[0];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: Text(news['titol'] ?? 'Noticia sin título'),
      ),
    );
  }
}
