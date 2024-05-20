import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Util/globals.dart';
import '../../Util/LateralMenu.dart';
import '../../Util/globals.dart';
import 'barallaDetailsPage.dart';
import '../homePage.dart';
import 'barallaEditPage.dart';
import 'newBarallaPage.dart';

class BarallesUser extends StatefulWidget {
  @override
  _BarallesUser createState() => _BarallesUser();
}

class _BarallesUser extends State<BarallesUser> {
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
        await http.get(Uri.parse('$API_URI_SERVER/getBarallaByUser/$userID'));

    print("STATUSCODE BARALLES USER: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        baralles = json.decode(response.body);
      });
      print(baralles.toString());
    } else {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                "Error carregant les baralles.. Codig d'error: $response.statusCode"),
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
            child: ListView.builder(
              itemCount: baralles.length,
              itemBuilder: (context, index) {
                var baralla = baralles[index];
                return ListTile(
                  title: Text(baralla['nomBaralla']),
                  subtitle: Text("Creado por: " + baralla['nickCreador']),
                  onTap: () {
                    // VER INFORMACIÓN DE LA BARAJA EN DETALLE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BarallaDetailsPage(
                                barallaID: baralla['idBaralla'],
                              )),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BarallaEditPage(barallaInfo: baralla),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //REDIRECT FORM OFERTA
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewBarallaPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        child: const Icon(Icons.add),
      ),
      drawer: LateralMenu(
        onTapLogout: () => logOut,
      ),
    );
  }
}
