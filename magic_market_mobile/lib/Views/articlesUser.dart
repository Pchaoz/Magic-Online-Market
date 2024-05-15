import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Util/globals.dart';

void main() {
  runApp(ArticlesUser());
}

class ArticlesUser extends StatefulWidget {
  @override
  _ArticlesUser createState() => _ArticlesUser();
}

class _ArticlesUser extends State<ArticlesUser> {
  @override
  void initState() {
    super.initState();

    fetchUserArticles();
  }

  Future fetchUserArticles() async {
    final response = await http.get(Uri.parse('$API_URI_LOCAL/lastNoticies'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Online Market',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Magic Online Market'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
