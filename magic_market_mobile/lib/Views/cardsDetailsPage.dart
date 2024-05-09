import 'package:flutter/material.dart';

import '../Util/globals.dart';
import 'homePage.dart';

class CardDetailPage extends StatelessWidget {
  final Map card;

  CardDetailPage({Key? key, required this.card}) : super(key: key);

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
              child: const Text('Veure ofertes'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {}, // TODO funcionalidad añadir a un mazo
              child: const Text('Afegir a baralla'),
            ),
          ],
        ),
      ),
    );
  }
}
