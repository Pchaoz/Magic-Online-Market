import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Util/globals.dart';
import '../../Util/globals.dart';
import 'editArticlePage.dart';

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
    print("INITSTATE ARTICLES");
    fetchUserArticles();
  }

  Future fetchUserArticles() async {
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/ofertesUsuari/$userID'));

    print("STATUSCODE: ${response.statusCode}");
    print("CARGANDO OFERTAS DE EL USUARIO: " + userID.toString());

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

  @override
  Widget build(BuildContext context) {
    myArticles = serverResponse['articles'] ?? [];
    products = serverResponse['producte'] ?? [];
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
                itemCount: myArticles.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
                itemBuilder: (context, index) {
                  var article = myArticles[index];
                  var product = products.firstWhere(
                      (p) => p['idProducte'] == article['idProducte'],
                      orElse: () => null);
                  return ListTile(
                    leading: product != null
                        ? Image.network(
                            URI_SERVER_IMAGES + "/" + product['imatge'])
                        : null,
                    title: Text(product != null
                        ? product['nom']
                        : 'Producto no encontrado'),
                    subtitle: Text("Quantitat: ${article['quantitat']}"),
                    trailing: Text('${article['preu']}€'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditArticlePage(
                                  article: article,
                                )),
                      );
                    },
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
