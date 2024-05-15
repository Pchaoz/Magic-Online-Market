import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Util/globals.dart';
import '../Util/globals.dart';

void main() {
  runApp(ArticlesUser());
}

class ArticlesUser extends StatefulWidget {
  @override
  _ArticlesUser createState() => _ArticlesUser();
}

class _ArticlesUser extends State<ArticlesUser> {
  Map<String, dynamic> serverResponse = {};
  List<dynamic> myArticles = [];
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();

    fetchUserArticles();
  }

  Future fetchUserArticles() async {
    final response =
        await http.get(Uri.parse('$API_URI_LOCAL/ofertesUsuari/$userID'));

    print("STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        serverResponse = json.decode(response.body);
      });
      print(
          serverResponse.toString()); //JUST CHECKING IN CASE THAT DOES NOT WORK
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Error carregant els articles..'),
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
        body: Column(
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 11, 214, 153),
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Les meves ofertes',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: serverResponse.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(serverResponse[index]['nick']),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
