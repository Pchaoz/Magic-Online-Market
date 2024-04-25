import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/Views/registerPage.dart';

import '../Util/globals.dart';
import 'homePage.dart';

void main() {
  runApp(LoginApp());
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  print("MAIL:$email PASSWORD: $password");

  final response = await http.post(
    Uri.parse('$API_URI_SERVER/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  //print("GET USERS STATUS CODE: " + getallsusers.statusCode.toString());
  print("GET USERS STATUS CODE: ${response.statusCode}");

  var responseData = response.body;
  // Decodificar la respuesta JSON a un Map
  var data = jsonDecode(responseData);
  // Printear el resultado
  print(data.toString());

  if (response.statusCode == 200) {
    //Usuari logeado correctamente, falta manejar el token de inicio de session
    setAuth(true, data['user']['nick']);
    return {'success': true};
  } else {
    // El usuario no se ha podido autentificar
    throw Exception('Failed to authenticate user');
  }
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      Map<String, dynamic> loginResponse = await loginUser(email, password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
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

  void _goToSignUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesion'),
      ),
      body: SingleChildScrollView(
        // Añade esto
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Assets/MMO_logo.png', height: 300),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar sesion'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _goToSignUpPage,
                child: const Text(
                  'No tienes cuenta? Registrate aqui.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 11, 214, 153),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
