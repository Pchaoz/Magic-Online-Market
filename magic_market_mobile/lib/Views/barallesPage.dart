import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Util/globals.dart';
import 'package:magic_market_mobile/Views/ballaDetailsPage.dart';
import '../Util/globals.dart';
import '../Util/lateralMenu.dart';
import 'homePage.dart';

class BarallesPage extends StatefulWidget {
  @override
  _BarallesPage createState() => _BarallesPage();
}

class _BarallesPage extends State<BarallesPage> {
  //VARIABLES
  List<dynamic> baralles = [];

  //FUNCIONES
  @override
  void initState() {
    super.initState();
    fetchMyDecks();
  }

  fetchMyDecks() async {
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/getAllBaralles'));

    print("STATUSCODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        baralles = json.decode(response.body);
      });
      print(baralles.toString());
    } else {
      final statusCode = response.statusCode.toString();
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                "Error carregant les baralles.. Codig d'error: $statusCode"),
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
        children: <Widget>[
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
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
              itemCount:
                  baralles.where((baralla) => baralla['isPublic'] == 1).length,
              itemBuilder: (context, index) {
                var baralla = baralles
                    .where((baralla) => baralla['isPublic'] == 1)
                    .toList()[index];
                return ListTile(
                  title: Text(baralla['nomBaralla']),
                  subtitle: Text("Creat per: " + baralla['nickCreador']),
                  onTap: () {
                    //VER INFORMACION BARAJA EN DETALLE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BarallaDetailsPage(baralla: baralla[index]),
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
        onTapLogout: () => logOut,
      ),
    );
  }
}
