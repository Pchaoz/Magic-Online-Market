import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Util/LateralMenu.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Profile'),
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

  void _LogOut() {
    // Implementa aquí la funcionalidad para cerrar sesión.
  }
}
