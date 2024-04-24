import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Util/LateralMenu.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
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
          title: Text('Profile'),
        ),
        body: Center(
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
