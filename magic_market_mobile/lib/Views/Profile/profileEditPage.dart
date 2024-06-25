import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/homePage.dart';

import '../../Util/globals.dart';
import 'profilePage.dart';

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
  String _paypalmail = '';
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
    List<dynamic> userInfoResolved = await userInfo;
    Map<String, dynamic> firstUser = userInfoResolved.first;

    print("LA PUTISIMA CONTRASEÑA ES: $_passwordActual");

    try {
      final response = await http.put(
        Uri.parse('$API_URI_SERVER/updateUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'idUsuari': firstUser['idUsuari'].toString(),
          'nick': _nick.isEmpty ? firstUser['nick'] : _nick,
          'name': _nombre.isEmpty ? firstUser['name'] : _nombre,
          'paypalmail':
              _paypalmail.isEmpty ? firstUser['paypal_email'] : _paypalmail,
          'cognom': firstUser['cognom'],
          'email': firstUser['email'],
          'passwordActual': _passwordActual,
          'password': _password.isEmpty ? '' : _password,
        }),
      );
      print("LA RESPUESTA DEL SERVIDOR ES: ${response.statusCode}");

      if (response.statusCode == 200) {
        setUsername(_nick);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Usuari actualizat correctament.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Tancar'),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
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
                child: const Text('Tancar'),
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
                width: double.infinity,
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
                      FutureBuilder<List<dynamic>>(
                        future: userInfo,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                              initialValue: snapshot.data?.first['nick'],
                              decoration: const InputDecoration(
                                labelText: 'Nick',
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
                      FutureBuilder<List<dynamic>>(
                        future: userInfo,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                              initialValue:
                                  snapshot.data?.first['name'].toString(),
                              decoration: const InputDecoration(
                                labelText: 'Nom',
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
                      FutureBuilder<List<dynamic>>(
                        future: userInfo,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                              initialValue: snapshot.data?.first['paypal_email']
                                  .toString(),
                              decoration: const InputDecoration(
                                labelText: 'Correu paypal',
                              ),
                              onSaved: (value) {
                                _paypalmail = value ?? '';
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
                            return 'Per favor, introdueix la teva contrasenya actual';
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
