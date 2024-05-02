import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Util/LateralMenu.dart';
import '../Util/globals.dart';
import 'cardsDetailsPage.dart';
import 'loginPage.dart';

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  List cards = [];
  String filter = '';

  // Función para obtener las cartas del servidor
  Future getCards() async {
    final response = await http.get(Uri.parse('$API_URI_SERVER/getAllCartes'));
    if (response.statusCode == 200) {
      setState(() {
        cards = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCards();
  }

  Color getColorByRarity(String rarity) {
    switch (rarity) {
      case 'Comun':
        return Colors.green;
      case 'Infrecuente':
        return Colors.blue;
      case 'Rara':
        return Colors.purple;
      case 'Mitica':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar las cartas segun el nombre de ellas
    List filteredCards = cards
        .where(
            (card) => card['nom'].toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: const Text('Cartas'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              setState(() {
                filter = value;
              });
            },
            decoration: const InputDecoration(
              labelText: "Buscar carta",
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredCards[index]['nom']),
                  subtitle: Text(
                    filteredCards[index]['raresa'],
                    style: TextStyle(
                      color: getColorByRarity(filteredCards[index]['raresa']),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CardDetailPage(card: filteredCards[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: LateralMenu(
        onTapLogout: () => _LogOut(context),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void _LogOut(context) {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("ERROR.. $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to authenticate user'),
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
}
