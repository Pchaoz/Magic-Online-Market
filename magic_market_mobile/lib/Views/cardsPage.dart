import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Util/LateralMenu.dart';
import '../Util/globals.dart';
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
      case 'comun':
        return Colors.green;
      case 'infrecuente':
        return Colors.blue;
      case 'rara':
        return Colors.purple;
      case 'mitica':
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

class CardDetailPage extends StatelessWidget {
  final Map card;

  CardDetailPage({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: Text(card['nom']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(card['nom'], style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(card['raresa'],
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                card['descripcio'],
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Image.network('$URI_SERVER_IMAGES/${card['imatge']}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {}, // TODO funcionalidad ver ofertas
              child: const Text('Ver ofertas'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {}, // TODO funcionalidad añadir a un mazo
              child: const Text('Añadir a mazo'),
            ),
          ],
        ),
      ),
    );
  }
}
