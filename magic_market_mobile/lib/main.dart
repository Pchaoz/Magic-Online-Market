import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aquí puedes agregar lógica para verificar si el usuario ha iniciado sesión o no
    // Por ejemplo, podrías utilizar un estado global, SharedPreferences, etc.
    bool isAuthenticated = false;

    return isAuthenticated ? HomePage() : LoginPage();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
