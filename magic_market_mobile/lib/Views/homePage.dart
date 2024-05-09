import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magic_market_mobile/Classes/product.dart';
import 'package:magic_market_mobile/Util/lateralMenu.dart';
import 'package:magic_market_mobile/Views/loginPage.dart';

import '../Util/globals.dart';
import 'newsDetailsPage.dart';

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
      title: 'Inici',
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
  List news = [];
  final List<String> images = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future fetchNews() async {
    final response = await http.get(Uri.parse('$API_URI_SERVER/lastNoticies'));

    print("LA RESPUESTA DEL SERVIDOR ES: ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body);
        for (var item in news) {
          images.add(URI_SERVER_IMAGES + item['imatge']);
        }
        print(images);
      });
    }
  }

  // ignore: non_constant_identifier_names
  void _LogOut() {
    try {
      logOut();

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
            content: const Text('Error tancant sessio..'),
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
        title: const Text('Magic Online Market'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 11, 214, 153),
              width: double
                  .infinity, // Asegura que el contenedor ocupe todo el ancho
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Inici',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CarouselSlider(
              items: images.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return GestureDetector(
                  onTap: () {
                    print('Imagen tocada: $item, índice: $index');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsPage(info: news[index]),
                      ),
                    );
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
                    'Producte',
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
