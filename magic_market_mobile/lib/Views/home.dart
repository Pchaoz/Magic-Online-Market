import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magic_market_mobile/Classes/product.dart';
import 'package:magic_market_mobile/Util/LateralMenu.dart';
import 'package:magic_market_mobile/Views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/globals.dart';

void main() {
  runApp(HomePage());
}

Future<List<Product>> obtenerProductos() async {
  final response =
      await http.get(Uri.parse(API_URI_SERVER + "/getLastProductes"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Error al obtener los productos.');
  }
}

Future<Map<String, dynamic>> logOut() async {
  final response = await http.post(
    Uri.parse(API_URI_SERVER + '/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

  print("GET USERS STATUS CODE: " + response.statusCode.toString());

  var responseData = response.body;
  // Decodificar la respuesta JSON a un Map
  var data = jsonDecode(responseData);
  // Printear el resultado
  print(data.toString());

  if (response.statusCode == 200) {
    //Usuario ha cerrado la session correctamente
    return {'success': true};
  } else {
    // El usuario no se ha podido desconectar
    throw Exception('Failed to logout');
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio',
      home: HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  int _current = 0;

  final List<String> images = [
    'https://media.wizards.com/2017/images/daily/41mztsnrdm.jpg',
    'https://via.placeholder.com/600x300?text=Image+2',
    'https://via.placeholder.com/600x300?text=Image+3',
  ];

  void _LogOut() {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("ERROR.. $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to authenticate user'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Noticias recientes'),
            CarouselSlider(
              items: images.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return GestureDetector(
                  onTap: () {
                    // Aquí puedes manejar el evento onTap.
                    // Por ejemplo, puedes usar Navigator para redirigir a otra página.
                    print('Imagen tocada: $item, índice: $index');
                  },
                  child: Container(
                    child: Center(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map((url) {
                int index = images.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromARGB(255, 11, 214, 153)
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Text('Productos recientes'),
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Producto',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Usuario',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Precio',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Mes ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Producto 1')),
                    DataCell(Text('Fecha 1')),
                    DataCell(Text('Precio 1')),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          // Implementar la acción de ver detalles
                        },
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Producto 2')),
                    DataCell(Text('Fecha 2')),
                    DataCell(Text('Precio 2')),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.add_outlined),
                        onPressed: () {
                          // Implementar la acción de ver detalles
                        },
                      ),
                    ),
                  ],
                ),
                //A partir de aqui puedo añadir mas filas
              ],
            ),
          ],
        ),
      ),
      drawer: LateralMenu(
        onTapLogout: _LogOut,
      ),
    );
  }
}
