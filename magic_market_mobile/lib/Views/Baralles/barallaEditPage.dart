import 'package:flutter/material.dart';
import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:magic_market_mobile/Views/News/newsPage.dart';

class BarallaEditPage extends StatefulWidget {
  Map<String, dynamic> barallaInfo;

  BarallaEditPage({super.key, required this.barallaInfo});

  @override
  _BarallaEditPage createState() => _BarallaEditPage();
}

class _BarallaEditPage extends State<BarallaEditPage> {
  //VARIABLES
  String nomBaralla = '';
  bool isPublic = false;

  //FUNCIONES
  void guardar() {}

  void borrar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Magic Online Market'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.barallaInfo['nomBaralla'],
                decoration: const InputDecoration(
                  labelText: 'Nom de la baralla',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el nombre de la baralla';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    nomBaralla = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('¿Es public?'),
                value: widget.barallaInfo['isPublic'] == 1,
                onChanged: (bool? value) {
                  setState(() {
                    isPublic = value!;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: guardar,
                    child: const Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: borrar,
                    child: const Text('Borrar'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
