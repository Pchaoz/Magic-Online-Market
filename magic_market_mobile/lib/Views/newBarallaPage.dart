import 'package:flutter/material.dart';

import 'homePage.dart';

class NewBarallaPage extends StatefulWidget {
  @override
  _NewBarallaPage createState() => _NewBarallaPage();
}

class _NewBarallaPage extends State<NewBarallaPage> {
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
    ));
  }
}
