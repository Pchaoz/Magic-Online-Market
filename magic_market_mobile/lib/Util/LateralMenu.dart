import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Views/home.dart';
import 'package:magic_market_mobile/Views/profile.dart';

import '../Util/globals.dart';

class LateralMenu extends StatelessWidget {
  final VoidCallback onTapLogout;

  LateralMenu({required this.onTapLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 11, 214, 153),
            ),
            child: Text(
              'Bienvenido ' + userName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color.fromARGB(255, 11, 214, 153)),
            title: Text('Incio'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileApp()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color.fromARGB(255, 11, 214, 153)),
            title: Text('Productos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileApp()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.article_rounded,
                color: Color.fromARGB(255, 11, 214, 153)),
            title: Text('Cartas'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileApp()),
              );
            },
          ),
          ListTile(
            leading:
                Icon(Icons.logout, color: Color.fromARGB(255, 11, 214, 153)),
            title: Text('Logout'),
            onTap: onTapLogout,
          ),
        ],
      ),
    );
  }
}
