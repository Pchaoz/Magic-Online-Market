import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Util/globals.dart';
import '../../Util/lateralMenu.dart';
import '../Profile/loginPage.dart';
import '../homePage.dart';
import 'cardsDetailsPage.dart';

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
                'Cartes',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "Buscar carta",
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredCards.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Color.fromRGBO(11, 214, 153, 0.5)),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      "$URI_SERVER_IMAGES/${filteredCards[index]['imatge']}",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
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
            content: const Text('Error tancant sessio..'),
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
}
