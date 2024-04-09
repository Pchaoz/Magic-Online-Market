import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late Size mediaSize;
  @override
  Widget build(BuildContext context) {

    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        image: DecorationImage(image: AssetImage("assets/image/magicjpgtestimage.jpg"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.dstATop)),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [],),
      ),
    );
  }

  /*Widget _buildTop() {
    return const SizedBox(
      width: mediaSize.width,
    ),
  }*/
}
