import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Util/globals.dart';

void main() {
  runApp(ProfileEditPage());
}

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPage createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEditPage> {
  late Future<List<dynamic>> userInfo;

  final _formKey = GlobalKey<FormState>();
  String _nick = '';
  String _nombre = '';
  String _password = '';
  String _passwordActual = '';

  @override
  void initState() {
    super.initState();
    userInfo = fetchUserInfo();
  }

  Future<List<dynamic>> fetchUserInfo() async {
    final response = await http.get(Uri.parse("$API_URI_SERVER/api/getUser"),
        headers: <String, String>{'nickname': userName});

    //print("STATUS CODE IS: ${response.statusCode}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editar Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Magic Online Market'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nick'),
                  onSaved: (value) {
                    _nick = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nom'),
                  onSaved: (value) {
                    _nombre = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contrasenya'),
                  obscureText: true,
                  onSaved: (value) {
                    _password = value ?? '';
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Contrasenya actual'),
                  obscureText: true,
                  onSaved: (value) {
                    _passwordActual = value ?? '';
                  },
                ),
                ElevatedButton(
                  child: const Text('Guardar'),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      // Aquí puedes agregar tu lógica para guardar los datos
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
