import 'package:flutter/material.dart';

import '../Util/globals.dart';

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
