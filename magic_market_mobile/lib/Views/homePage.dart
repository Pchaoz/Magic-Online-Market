import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magic_market_mobile/Classes/product.dart';
import 'package:magic_market_mobile/Util/lateralMenu.dart';
import 'package:magic_market_mobile/Views/loginPage.dart';

import '../Util/globals.dart';

void main() {
  runApp(HomePage());
}

Future<List<Product>> obtenerProductos() async {
  final response =
      await http.get(Uri.parse("$API_URI_SERVER/getLastProductes"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Error al obtener los productos.');
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

  // ignore: non_constant_identifier_names
  void _LogOut() {
    try {
      logOut();
      clearPrefs();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        title: const Text('Inicio'),
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
                  child: Center(
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
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
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? const Color.fromARGB(255, 11, 214, 153)
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(125, 11, 214, 153)),
              columns: const <DataColumn>[
                DataColumn(
                    label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Producto',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )),
                DataColumn(
                    label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Usuario',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )),
                DataColumn(
                    label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Precio',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )),
                DataColumn(
                    label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Mas',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )),
              ],
              rows: List<DataRow>.generate(
                10,
                (index) => DataRow(
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (index % 2 == 0) {
                      return Colors.white;
                    }
                    return const Color.fromARGB(101, 207, 207, 207);
                  }),
                  cells: <DataCell>[
                    DataCell(
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Producto ${index + 1}'),
                      ),
                    ),
                    DataCell(
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Usuario ${index + 1}'),
                      ),
                    ),
                    DataCell(
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Precio ${index + 1}'),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        color: const Color.fromARGB(255, 11, 214, 153),
                        onPressed: () {
                          // Implementar la acción de ver detalles
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
