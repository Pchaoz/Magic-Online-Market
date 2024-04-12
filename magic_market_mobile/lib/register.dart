import 'package:flutter/material.dart';
import 'package:magic_market_mobile/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  @override
  Widget build(BuildContext context) {
    //VARIABLES

    //V - FORM REGISTER
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final lastnameController = TextEditingController();

    //V - ETC
    bool _passwordVisible = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("REGISTER"),
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
                  helperText: 'Maxim de 20 caracters',
                  /*suffixIcon: Icon(
                  Icons.check_circle,
                ),*/
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)))),
            ),

            //INPUT MAIL
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                labelText: 'Correu',
                labelStyle: TextStyle(color: Color(0xFF6200EE)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE))),
              ),
            ),
            //INPUT PASSWORD
            TextFormField(
              keyboardType: TextInputType.name,
              controller: passwordController,
              obscureText: !_passwordVisible,
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                labelText: 'Contrasenya',
                labelStyle: TextStyle(color: Color(0xFF6200EE)),
                helperText: 'La contrasenya ha de tindre mes de 8 caracters',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE))),
              ),
            ),
            //INPUT PASSWORD CONFIRM
            TextFormField(
              keyboardType: TextInputType.name,
              controller: passwordConfirmController,
              obscureText: !_passwordVisible,
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                labelText: 'Confirma contrasenya',
                labelStyle: TextStyle(color: Color(0xFF6200EE)),
                helperText: 'Repeteix la contrasenya anterior',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE))),
              ),
            ),
            //INPUT NAME
            TextFormField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Nom',
                labelStyle: TextStyle(color: Color(0xFF6200EE)),
                helperText: '',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE))),
              ),
            ),
            //INPUT LASTNAME
            TextFormField(
              keyboardType: TextInputType.text,
              controller: lastnameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Cognoms',
                labelStyle: TextStyle(color: Color(0xFF6200EE)),
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

                //MIENTRAS NO TENGA ACCESO A BASE DE DATOS
                _errorNoConn(context);
              },
              child: const Text('CheckLogin'),
            ),
            OutlinedButton(
              onPressed: () {
                print("LOADING LOGIN  PAGE");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text('Ya tengo cuenta'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _errorNoConn(BuildContext context) {
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
