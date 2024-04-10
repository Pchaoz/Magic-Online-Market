import 'package:flutter/material.dart';
import 'package:magic_market_mobile/dashaboard.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body:  Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
              if (1==1) {
                //AQUI VA LA FUNCION PARA COMPROBAR SI EL LOGIN ES CORRECTO 👍
              }
              },
              child: const Text('CheckLogin'),
                         
            )
          ],
        ),
      ),
    );
  }
}