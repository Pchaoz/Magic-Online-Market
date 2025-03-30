import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Util/globals.dart';
import '../homePage.dart';
import '../Products/productsDetailsPage.dart';

class WishListDetails extends StatefulWidget {
  final int wishlistID;

  const WishListDetails({Key? key, required this.wishlistID}) : super(key: key);

  @override
  _WishListDetails createState() => _WishListDetails();
}

class _WishListDetails extends State<WishListDetails> {
  // Variables
  var wl_id;
  Map<String, dynamic>? wishlistData;
  List<dynamic> wishlistProducts = [];
  var statuscode = 200;

  // Funciones
  @override
  void initState() {
    super.initState();
    wl_id = widget.wishlistID;
    fetchWishList();
  }

  void _removeFromWishlist(int wl_pID) async {
    final response = await http.delete(
      Uri.parse('$API_URI_SERVER/removeFromWishlist'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'idWishListProducte': wl_pID,
      }),
    );
    statuscode = response.statusCode;

    if (response.statusCode == 200) {
      setState(() {
        wishlistProducts
            .removeWhere((product) => product['idProducte'] == wl_pID);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto eliminado de la wishlist'),
          duration: Duration(seconds: 2),
        ),
      );
      fetchWishList();
    } else {
      print('Error al eliminar de wishlist: ${response.statusCode}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al eliminar de wishlist'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void fetchWishList() async {
    final response = await http
        .get(Uri.parse('$API_URI_SERVER/getWishListByWishListID/$wl_id'));

    print(
        "FETCH WISHLIST WITH ID $wl_id RESULT STATUSCODE: ${response.statusCode}");
    if (response.statusCode == 200) {
      setState(() {
        wishlistData = json.decode(response.body)['wishlist'];
        wishlistProducts = json.decode(response.body)['whishlistProductes'];
      });
      print(wishlistData);
      print(wishlistProducts);
    } else if (response.statusCode == 400) {
      print(json.decode(response.body)["message"]);
      showDialog(
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
    } else {
      print("Unexpected error: ${response.statusCode}");
    }
  }

  void _showPopupMenu(BuildContext context, Offset position, int wlPid) {
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
          value: 'remove_from_wishlist',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.black),
              SizedBox(width: 8),
              Text('Eliminar de wishlist',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ).then((value) {
      if (value == 'remove_from_wishlist') {
        _removeFromWishlist(wlPid);
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
      body: wishlistProducts.isEmpty && statuscode != 200
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: wishlistProducts.length,
              itemBuilder: (context, index) {
                final product = wishlistProducts[index];
                return GestureDetector(
                  onTap: () {
                    print("trying to push ${wishlistProducts[index]}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: wishlistProducts[index]),
                      ),
                    );
                  },
                  onLongPressStart: (details) {
                    _showPopupMenu(
                        context, details.globalPosition, product['idwp']);
                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: Image.network(
                        product['imatge'] != null
                            ? '$URI_SERVER_IMAGES/${product['imatge']}'
                            : '$URI_SERVER_IMAGES/default.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    title: Text(product['nomProducte'] ?? ""),
                  ),
                );
              },
            ),
    );
  }
}
