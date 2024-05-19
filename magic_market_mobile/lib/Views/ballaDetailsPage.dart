import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/newsDetailsPage.dart';
import 'dart:convert';

import '../Util/globals.dart';
import 'homePage.dart';

class BarallaDetailsPage extends StatefulWidget {
  final int barallaID;

  const BarallaDetailsPage({Key? key, required this.barallaID})
      : super(key: key);

  @override
  __BarallaDetailsPage createState() => __BarallaDetailsPage();
}

class __BarallaDetailsPage extends State<BarallaDetailsPage> {
  //VARIABLES
  Map<String, dynamic> requestInfo = {};

  //FUNCTIONS
  @override
  void initState() {
    super.initState();
    fetchDeck();
  }

  void fetchDeck() async {
    final response = await http
        .get(Uri.parse("$API_URI_SERVER/getBarallaByID/$widget.barallaID"));

    print("EL STATUSCODE DE BARALLA DETAILS ES: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        requestInfo = json.decode(response.body);
      });
      print(requestInfo);
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
      body: Column(children: <Widget>[
        Container(
          color: const Color.fromARGB(255, 11, 214, 153),
          width: double.infinity,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Totes les baralles',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: requestInfo['cartesBaralla'] != null
              ? ListView.builder(
                  itemCount: requestInfo['cartesBaralla'].length,
                  itemBuilder: (context, index) {
                    var carta = requestInfo['cartesBaralla'][index];
                    var cartaInfo = requestInfo['cartes']
                        .firstWhere((c) => c['idCarta'] == carta['idCarta']);
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                            "$URI_SERVER_IMAGES/" + cartaInfo['imatge']),
                        title: Text(cartaInfo['nom']),
                        subtitle: Text('Cantidad: ${carta['quantitat']}'),
                      ),
                    );
                  },
                )
              : const Center(
                  child:
                      CircularProgressIndicator()), // muestra un indicador de carga si 'cartesBaralla' es null
        )
      ]),
    );
  }
}
