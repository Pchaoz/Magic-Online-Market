import 'package:flutter/material.dart';

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
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
            onTap: () {
              // Implementar la acción de Perfil
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Productos'),
            onTap: () {
              // Implementar la acción de Productos
            },
          ),
          ListTile(
            leading: Icon(Icons.article_rounded),
            title: Text('Cartas'),
            onTap: () {
              // Implementar la acción de Cartas
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: onTapLogout,
          ),
        ],
      ),
    );
  }
}
