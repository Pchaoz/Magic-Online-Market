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
  late Future<Map<String, dynamic>> userInfo;

  final _formKey = GlobalKey<FormState>();
  String _nick = '';
  String _nombre = '';
  String _password = '';
  String _passwordActual = '';

  @override
  void initState() {
    super.initState();
    try {
      userInfo = fetchUserInfo();
    } catch (e) {
      print(e);
    }
  }

  _updateUser() {
    print("INTENTADO ACTUALIZAR EL USUARIO!");
    updateUser();
  }

  Future<void> updateUser() async {
    Map<String, dynamic> userInfoResolved = await userInfo;

    print("LA PUTISIMA CONTRASEÑA ES: $_passwordActual");

    try {
      final response = await http.put(
        Uri.parse('$API_URI_SERVER/updateUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'idUsuari': userInfoResolved['idUsuari'].toString(),
          'nick': _nick.isEmpty ? userInfoResolved['nick'] : _nick,
          'name': _nombre.isEmpty ? userInfoResolved['name'] : _nombre,
          'cognom': userInfoResolved['cognom'],
          'email': userInfoResolved['email'],
          'passwordActual': _passwordActual,
          'password': _password.isEmpty ? '' : _password,
        }),
      );

      print("LA RESPUESTA DEL SERVIDOR ES: ${response.statusCode}");

      if (response.statusCode == 200) {
        // Si el servidor devuelve una respuesta OK, parseamos el JSON.
        print('Usuario actualizado con éxito. ');
      } else {
        // Si la respuesta no es OK, lanzamos un error.
        throw Exception(json.decode(response.body)['message'].toString());
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
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

  Future<Map<String, dynamic>> fetchUserInfo() async {
    print("USUARIO A CARGAR INFO: $userName");
    final response =
        await http.get(Uri.parse("$API_URI_SERVER/getUser?nickname=$userName"));

    print("STATUS CODE IS: ${response.statusCode}");
    print("ME DEVUELVE: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['message']);
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
          body: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 11, 214, 153),
                width: double
                    .infinity, // Asegura que el contenedor ocupe todo el ancho
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Modifica el teu perfil',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      FutureBuilder<Map<String, dynamic>>(
                        future: userInfo,
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nick',
                                hintText: snapshot.data?['nick'],
                              ),
                              onSaved: (value) {
                                _nick = value ?? '';
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      FutureBuilder<Map<String, dynamic>>(
                        future: userInfo,
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                hintText: snapshot.data?['name'].toString(),
                              ),
                              onSaved: (value) {
                                _nombre = value ?? '';
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Contrasenya'),
                        obscureText: true,
                        onSaved: (value) {
                          _password = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Contrasenya actual'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduce tu contraseña actual';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _passwordActual = value ?? '';
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          child: const Text('Guardar'),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              _updateUser();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
