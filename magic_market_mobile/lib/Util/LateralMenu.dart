import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Views/cardsPage.dart';
import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:magic_market_mobile/Views/loginPage.dart';
import 'package:magic_market_mobile/Views/newsPage.dart';
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
    reloadPref(context);
    loadLateralMenu(context);
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
            child: welcomeMessage,
          ),
          ListTile(
            leading: const Icon(Icons.home,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Inici'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          profileListTitle,
          ListTile(
            leading: const Icon(Icons.newspaper,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: const Text('Noticies'),
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
            title: const Text('Productes'),
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
            title: const Text('Cartes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CardsPage()),
              );
            },
          ),
          shoppingCartListTitle,
          logOutListTitle,
        ],
      ),
    );
  }
}
