import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';
import 'home.dart';
import 'login.dart';

void main() {
  runApp(AuthenticationApp());
}

void initState() {
  _loadPreferences();
}

_loadPreferences() async {
  print("CARGANDO PREFERENCIAS !!!!!!!!!!!!!!");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("Auth")) {
    isAuthenticated = prefs.getBool("Auth")!;
  } else {
    isAuthenticated = false;
    prefs.setBool("Auth", isAuthenticated);
  }
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
    print("ESTADO DEL AUTH " + isAuthenticated.toString());
    return isAuthenticated ? HomePage() : LoginPage();
  }
}
