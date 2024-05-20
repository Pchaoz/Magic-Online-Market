import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:magic_market_mobile/Views/News/newsPage.dart';

class BarallaEditPage extends StatefulWidget {
  Map<String, dynamic> barallaInfo;

  BarallaEditPage({super.key, required this.barallaInfo});

  @override
  _BarallaEditPage createState() => _BarallaEditPage();
}

class _BarallaEditPage extends State<BarallaEditPage> {
  //VARIABLES

  //FUNCIONES

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
