import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Util/LateralMenu.dart';
import 'package:magic_market_mobile/Views/articlesUser.dart';
import 'package:magic_market_mobile/Views/homePage.dart';

import '../Util/globals.dart';
import 'loginPage.dart';
import 'profileEditPage.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Perfil',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: ListTile.divideTiles(context: context, tiles: [
                  ListTile(
                    title: const Center(child: Text('Modificar perfil')),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileEditPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Center(child: Text('Baralles')),
                    onTap: () {
                      // Navegar a la pagina de Barajas
                    },
                  ),
                  if (roleID == 1 || roleID == 2 || roleID == 4 || roleID == 5)
                    ListTile(
                      title: const Center(child: Text('Les meves ofertes')),
                      onTap: () {
                        // Navegar a la pagina de "mis ofertas"
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlesUser(),
                          ),
                        );
                      },
                    )
                ]).toList(),
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

  // ignore: non_constant_identifier_names
  void _LogOut(context) {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("ERROR.. $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to authenticate user'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
