import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Util/LateralMenu.dart';
import '../Util/globals.dart';

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
                  subtitle: Text(filteredCards[index]['raresa']),
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
        onTapLogout: _LogOut,
      ),
    );
  }

  void _LogOut() {}
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(card['nom'], style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20), // Espacio entre los elementos
            Text(card['raresa'],
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 20), // Espacio entre los elementos
            Flexible(
              child: Text(
                card['descripcio'],
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(height: 20), // Espacio entre los elementos
            Flexible(
              child: Center(
                // Centrar la imagen
                child: Image.network('$URI_SERVER_IMAGES/${card['imatge']}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
