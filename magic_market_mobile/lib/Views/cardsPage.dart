import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:magic_market_mobile/Util/globals.dart';

void main() {
  runApp(CardsPage());
}

class CardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 214, 153),
          title: const Text('Cartas'),
        ),
        body: FutureBuilder<List>(
          future: fetchCards(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                        label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Nombre',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )),
                    DataColumn(
                        label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Rareza',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )),
                    DataColumn(
                        label: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Detalles',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    )),
                  ],
                  rows: snapshot.data!
                      .map((item) => DataRow(cells: <DataCell>[
                            DataCell(FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(item['nom'] ?? 'Desconocido'),
                            )),
                            DataCell(FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(item['raresa'] ?? 'Desconocido'),
                            )),
                            DataCell(FittedBox(
                              fit: BoxFit.scaleDown,
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(item['idCarta'] ?? 0),
                                    ),
                                  );
                                },
                              ),
                            )),
                          ]))
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List> fetchCards() async {
    final response = await http.get(Uri.parse('$API_URI_SERVER/getAllCartes'));

    print("STATUS GET CARTES: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cards');
    }
  }
}

class DetailPage extends StatelessWidget {
  final int idCarta;

  const DetailPage(this.idCarta, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la carta $idCarta'),
      ),
      body: Center(
        child: Text('Aquí van los detalles de la carta $idCarta'),
      ),
    );
  }
}
