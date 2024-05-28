import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Util/globals.dart';
import '../homePage.dart';

class AddToWishListPage extends StatefulWidget {
  final int productID;

  const AddToWishListPage({Key? key, required this.productID})
      : super(key: key);

  @override
  _AddToWishList createState() => _AddToWishList();
}

class _AddToWishList extends State<AddToWishListPage> {
  List<dynamic> wishLists = [];
  String? selectedWishlist;
  int? selectedWishlistID;

  @override
  void initState() {
    super.initState();
    print(widget.productID.toString());
    fetchWishLists();
  }

  void fetchWishLists() async {
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/getWishlistUser/$userID'));

    print("STATUSCODE GET WISHLISTS USER -> $userID : ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        wishLists = json.decode(response.body)['wishlists'];
      });
      print(wishLists.toString());
    } else if (response.statusCode == 400) {
      print(json.decode(response.body)["message"]);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                "Error carregant les wishlists.. Codig d'error: ${response.statusCode}"),
            actions: <Widget>[
              TextButton(
                child: const Text('Tancar'),
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

  void addToWishlist() async {
    var idProdcut = widget.productID;
    print(idProdcut.toString());
    print(selectedWishlistID);

    if (selectedWishlistID != null) {
      final response = await http
          .post(Uri.parse('$API_URI_SERVER/addProductToWishlist'), body: {
        'idWishlist': selectedWishlistID.toString(),
        'idProducte': idProdcut.toString(),
      });

      print("LA RESPUESTA DEL AGREGAR A WISHLIST ES -> ${response.statusCode}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Producte afegit a la wishlist'),
        ));
      } else {
        if (response.statusCode == 400) {
          print(json.decode(response.body.toString()));
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                  "Error agregant el producte a la wishlist.. Codig d'error: ${response.statusCode}"),
              actions: <Widget>[
                TextButton(
                  child: const Text('Tancar'),
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
          children: [
            const Text(
              'Selecciona una wishlist',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedWishlist,
              hint: const Text('Selecciona una wishlist'),
              items: wishLists.map<DropdownMenuItem<String>>((wishlist) {
                return DropdownMenuItem<String>(
                  value: wishlist['nomWishlist'],
                  child: Text(wishlist['nomWishlist']),
                  onTap: () {
                    selectedWishlistID = wishlist['idWishlist'];
                  },
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedWishlist = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addToWishlist,
              child: const Text('Afegir a la wishlist'),
            ),
          ],
        ),
      ),
    );
  }
}
