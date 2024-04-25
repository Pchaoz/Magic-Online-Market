import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Util/LateralMenu.dart';

void main() {
  runApp(CardsPage());
}

class CardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Cards'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
        drawer: LateralMenu(
          onTapLogout: _LogOut,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void _LogOut() {
    //TODO Hacer el logout una funcion global para poder acceder desde todas partes sin repetir codigo.
  }
}
