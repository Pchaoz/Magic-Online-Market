import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Util/globals.dart';

class WishListDetails extends StatefulWidget {
  final int wishlistID;

  const WishListDetails({Key? key, required this.wishlistID}) : super(key: key);

  @override
  _WishListDetails createState() => _WishListDetails();
}

class _WishListDetails extends State<WishListDetails> {
  @override
  void initState() {
    super.initState();
    fetchWishList();
  }

  void fetchWishList() async {
    final response = await http.get(Uri.parse(
        '$API_URI_SERVER/getWishListByWishListID/$widget.wishlistID'));

    //TOOD
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
