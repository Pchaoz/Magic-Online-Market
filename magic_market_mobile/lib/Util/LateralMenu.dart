import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Views/cardsPage.dart';
import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:magic_market_mobile/Views/newsCard.dart';
import 'package:magic_market_mobile/Views/productsPage.dart';
import 'package:magic_market_mobile/Views/profilePage.dart';

import '../Util/globals.dart';

class LateralMenu extends StatefulWidget {
  final VoidCallback onTapLogout;

  LateralMenu({required this.onTapLogout});

  @override
  _LateralMenuState createState() => _LateralMenuState();
}

class _LateralMenuState extends State<LateralMenu> {
  @override
  void initState() {
    super.initState();
    reloadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 11, 214, 153),
            ),
            child: Text(
              'Bienvenido $userName',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Incio'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NewsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Productos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article_rounded,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Cartas'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CardsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Cesta compra'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CardsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Logout'),
            onTap: widget.onTapLogout,
          ),
        ],
      ),
    );
  }
}
