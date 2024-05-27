import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Util/LateralMenu.dart';
import '../../Util/globals.dart';
import '../homePage.dart';
import 'newWishListPage.dart';
import 'wishListDetails.dart';

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

  void _removeWishlist(int wishlistID) async {
    final response = await http.delete(
      Uri.parse('$API_URI_SERVER/removeWishlist'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'idWishlist': wishlistID,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        wishLists['wishlists']
            .removeWhere((wishlist) => wishlist['idWishlist'] == wishlistID);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wishlist eliminada'),
          duration: Duration(seconds: 2),
        ),
      );
      fetchWishLists();
    } else {
      print('Error al eliminar la wishlist: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al eliminar la wishlist'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showPopupMenu(BuildContext context, Offset position, int wishlistID) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'remove_wishlist',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.black),
              SizedBox(width: 8),
              Text('Eliminar wishlist', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ).then((value) {
      if (value == 'remove_wishlist') {
        _removeWishlist(wishlistID);
      }
    });
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
            child: wishLists == {} || wishLists['wishlists'] == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: wishLists['wishlists'].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WishListDetails(
                                wishlistID: wishLists['wishlists'][index]
                                    ['idWishlist'],
                              ),
                            ),
                          )
                        },
                        onLongPressStart: (details) {
                          _showPopupMenu(context, details.globalPosition,
                              wishLists['wishlists'][index]['idWishlist']);
                        },
                        child: ListTile(
                          title: Text(
                              wishLists['wishlists'][index]['nomWishlist']),
                          subtitle: Text("Creat per: " +
                              wishLists['wishlists'][index]['nickPropietari']),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
