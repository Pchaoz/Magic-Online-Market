import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Util/globals.dart';
import '../homePage.dart';

class WishListDetails extends StatefulWidget {
  final int wishlistID;

  const WishListDetails({Key? key, required this.wishlistID}) : super(key: key);

  @override
  _WishListDetails createState() => _WishListDetails();
}

class _WishListDetails extends State<WishListDetails> {
  //VARIABLES
  var wl_id;

  //FUNCINOES
  @override
  void initState() {
    super.initState();
    wl_id = widget.wishlistID;
    fetchWishList();
  }

  void fetchWishList() async {
    final response = await http
        .get(Uri.parse('$API_URI_SERVER/getWishListByWishListID/$wl_id'));

    print(
        "FETCH WISHLIST WITH ID $wl_id RESULT STATUSCODE: ${response.statusCode}");
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {
      print(json.decode(response.body)["message"]);
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
                "Error carregant les wishlists.. Error: ${json.decode(response.body)["message"]}"),
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
    } else {}
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
    ));
  }
}
