import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/News/newsDetailsPage.dart';
import 'dart:convert';

import '../../Util/globals.dart';
import '../Cards/addCartBarallaPage.dart';
import '../homePage.dart';

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
  var barallaName = "";

  //FUNCTIONS
  @override
  void initState() {
    super.initState();
    fetchDeck();
  }

  void fetchDeck() async {
    print("PILLANDO INFO DE LA BARALLA -> ${widget.barallaID}");
    final response = await http
        .get(Uri.parse("$API_URI_SERVER/getBarallaByID/${widget.barallaID}"));

    print("EL STATUSCODE DE BARALLA DETAILS ES: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        requestInfo = json.decode(response.body);
        barallaName = requestInfo['baralla']['nomBaralla'];
      });
      print(requestInfo);
      //print(requestInfo['baralla']['nomBaralla']);
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Cartes de " + barallaName,
              style: const TextStyle(fontSize: 24),
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
              : const Center(child: CircularProgressIndicator()),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //REDIRECT FORM OFERTA
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddCardBarallaPage(
                      barallaID: widget.barallaID,
                    )),
          );
        },
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        child: const Icon(Icons.add),
      ),
    );
  }
}
