import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Util/LateralMenu.dart';
import 'package:magic_market_mobile/Views/homePage.dart';

import '../Util/globals.dart';
import 'loginPage.dart';

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
        body: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 11, 214, 153),
              width: double
                  .infinity, // Asegura que el contenedor ocupe todo el ancho
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Perfil',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text('Hello World!'),
              ),
            ),
          ],
        ),
        drawer: LateralMenu(
          onTapLogout: () => _LogOut(context),
        ),
      ),
    );
  }

  void _LogOut(context) {
    // ...
  }
}
