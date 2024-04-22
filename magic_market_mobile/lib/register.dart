import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:magic_market_mobile/globals.dart';
import 'package:magic_market_mobile/home.dart';

import 'login.dart';

void main() {
  runApp(RegisterPage());
}

//await registerUser(firstName, lastName, nickname, email, password);
Future<Map<String, dynamic>> registerUser(String firstName, String lastName,
    String nickname, String email, String password) async {
  final Uri uri = Uri.parse(API_URI_SERVER + '/register');

  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstName,
      'email': email,
      'password': password,
      'lastName': lastName,
      'nickname': nickname,
    }),
  );

  print("El statuscode de la peticion de registro es: " +
      response.statusCode.toString());

  // Supongamos que 'response' es la respuesta de tu solicitud HTTP
  var responseData = response.body;

// Decodificar la respuesta JSON a un Map
  var data = jsonDecode(responseData);

  print(data.toString());

  if (response.statusCode == 200) {
    // Usuario registrado correctamente
    setAuth(true);
    return {'success': true};
  } else {
    // Error al registrar el usuario
    if (data["email"] == "[The email field must be a valid email address.]") {
      throw Exception('Correo ya registrado..');
    }
    throw Exception('Failed to register user');
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String nickname = _nicknameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      print("FirstName: " +
          firstName +
          "\n" +
          "LastName: " +
          lastName +
          "\n" +
          "Nickname: " +
          nickname +
          "\n" +
          "Email: " +
          email +
          "\n" +
          "Password: " +
          password);

      try {
        print("Tamaño password: " + password.length.toString());

        Map<String, dynamic> registerResponse =
            await registerUser(firstName, lastName, nickname, email, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
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

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('Assets/MMO_logo.png', height: 200),
                SizedBox(height: 20),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce tu nombre';
                    }
                    if (value.length < 2) {
                      return 'El nombre debe tener al menos 2 caracteres';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Apellidos'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce tus apellidos';
                    }
                    if (value.length < 2) {
                      return 'El nombre debe tener al menos 2 caracteres';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nicknameController,
                  decoration: InputDecoration(labelText: 'Nickname'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce tu nickname';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce tu email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduce tu contraseña';
                    }
                    if (value.length < 8) {
                      return 'La contraseña debe tener al menos 8 caracteres';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirmar Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, confirma tu contraseña';
                    }
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Registrar'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _goToLoginPage,
                  child: Text(
                    '¿Ya tienes una cuenta? Inicia sesión aquí',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
