import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Util/LateralMenu.dart';
import '../../Util/globals.dart';
import '../homePage.dart';
import 'newWishListPage.dart';

void main() {
  runApp(WishListsPage());
}

class WishListsPage extends StatefulWidget {
  @override
  _WishListPage createState() => _WishListPage();
}

class _WishListPage extends State<WishListsPage> {
  Map<String, dynamic> wishLists = {};

  @override
  void initState() {
    super.initState();
    fetchWishLists();
  }

  void fetchWishLists() async {
    final response =
        await http.get(Uri.parse('$API_URI_SERVER/getWishlistUser/$userID'));

    print("STATUSCODE WISHLISTS USER -> $userID : ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        wishLists = json.decode(response.body);
      });
      print(wishLists.toString());
    } else if (response.statusCode == 400) {
      print(json.decode(response.body)["message"]);
    } else {
      showDialog(
        // ignore: use_build_context_synchronously
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
      body: Column(
        children: <Widget>[
          Container(
              color: const Color.fromARGB(255, 11, 214, 153),
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Totes les wishlists',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
            child: ListView.builder(
                itemCount: wishLists.length, itemBuilder: (context, index) {}),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //REDIRECT FORM OFERTA
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewWishListPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 11, 214, 153),
        child: const Icon(Icons.add),
      ),
      drawer: LateralMenu(
        onTapLogout: () => logOut,
      ),
    );
  }
}
