import 'package:flutter/material.dart';
import 'package:magic_market_mobile/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _MyLogin createState() => _MyLogin();
}

class _MyLogin extends State<Login> {
  @override
  Widget build(BuildContext context) {
    //VARIABLES

    //V - FORM LOGIN
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    //V - ETC
    bool _passwordVisible = false;

    //LAYOUT
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //INPUT USERNAME
            TextFormField(
              controller: usernameController,
              maxLength: 20,
              decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Usuari',
                  labelStyle: TextStyle(color: Color(0xFF6200EE)),
                  helperText: '',
                  /*suffixIcon: Icon(
                  Icons.check_circle,
                ),*/
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)))),
            ),

            //INPUT CONTRASENYA
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              maxLength: 20,
              obscureText: !_passwordVisible,
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                labelText: 'Contrasenya',
                labelStyle: TextStyle(color: Color(0xFF6200EE)),
                helperText: '',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE))),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                print("USERNAME: " +
                    usernameController.text +
                    " PASSWORD: " +
                    passwordController.text);
                _dialogBuilder(context);
              },
              child: const Text('CheckLogin'),
            ),
            OutlinedButton(
              onPressed: () {
                print("LOADING REGISTER PAGE");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: const Text('Registrarse'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ERROR'),
          content: Text('NO SE PUEDE CONECTAR CON LA \n'
              'BASE DE DATOS..'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }
}
