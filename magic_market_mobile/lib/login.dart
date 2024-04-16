import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/register.dart';

import 'home.dart';

void main() {
  runApp(LoginApp());
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  print("MAIL:" + email + " PASSWORD: " + password);

  //IP SERVIDOR -> 162.19.74.238:8080
  //IP LOCAL PRUEBAS -> 10.1.85.13:8000

  /* final getallsusers =     //ESTA FUNCONA
      await http.get(Uri.parse('http://10.1.85.13:8000/getAllUsers')); */

  final response = await http.post(
    Uri.parse('http://162.19.74.238:8080/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  //print("GET USERS STATUS CODE: " + getallsusers.statusCode.toString());
  print("GET USERS STATUS CODE: " + response.statusCode.toString());

  if (response.statusCode == 200) {
    //Usuari logeado correctamente, falta manejar el token de inicio de session
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
      print('Login response: $loginResponse');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print("ERROR.. $e");
    }
  }

  void _goToSignUpPage() {
    Navigator.pushReplacement(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _goToSignUpPage,
              child: Text(
                'Don\'t have an account? Sign up here',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
