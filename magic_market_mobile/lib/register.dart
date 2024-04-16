import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'login.dart';

void main() {
  runApp(RegisterPage());
}

Future<Map<String, dynamic>> registerUser(String name, String email,
    String password, String cognom, String nick) async {
  final Uri uri = Uri.parse('http://10.1.85.13:8000/api/register');

  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'cognom': cognom,
      'nick': nick,
      'email': email,
      'password': password,
    }),
  );

  print("El statuscode de la peticion de registro es: " +
      response.statusCode.toString());

  if (response.statusCode == 200) {
    // Usuario registrado correctamente
    return {'success': true};
  } else {
    // Error al registrar el usuario
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

      try {
        if (_passwordController.text != _confirmPasswordController.text) {
          throw Exception('Las contraseñas no coinciden');
        }
        Map<String, dynamic> registerResponse =
            await registerUser(firstName, lastName, nickname, email, password);
        print('Register response: $registerResponse');
      } catch (e) {
        print("ERROR.. $e");
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce tu nombre';
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
                decoration: InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, introduce tu correo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una contraseña.';
                  } else if (value.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, confirma tu contraseña';
                  } else if (value.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres.';
                  } else if (value != _passwordController.text) {
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
    );
  }
}
