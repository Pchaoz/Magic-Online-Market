import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magic_market_mobile/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

void main() {
  runApp(HomePage());
}

void LogOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isAuthenticated = false;
  prefs.setBool("Auth", isAuthenticated);
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
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
    'https://via.placeholder.com/600x300?text=Image+1',
    'https://via.placeholder.com/600x300?text=Image+2',
    'https://via.placeholder.com/600x300?text=Image+3',
  ];

  void _LogOut() {
    LogOut();
    Navigator.pushReplacement(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      body: Column(
        children: [
          CarouselSlider(
            items: images.map((item) {
              return Container(
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.blue : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Implementar la acción de Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Implementar la acción de About
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _LogOut,
            ),
          ],
        ),
      ),
    );
  }
}
