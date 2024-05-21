import 'package:magic_market_mobile/Views/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Views/Cards/cardsPage.dart';
import '../Views/Profile/loginPage.dart';
import '../Views/Profile/profilePage.dart';

//IP SERVIDOR -> 162.19.74.238:8080
//IP LOCAL PRUEBAS -> 10.1.85.13:8000

String API_URI_CASA = 'http://192.168.0.20:8000/api';
String API_URI_LOCAL = 'http://10.1.85.13:8000/api';
String API_URI_SERVER = 'http://162.19.74.238:8080/api';
String URI_SERVER_IMAGES = 'http://162.19.74.238:8080/images';

//LATERAL MENU THINGS
var logOutListTitle;
var profileListTitle;
var shoppingCartListTitle;
var welcomeMessage;

//AUTH THINGS
bool isAuthenticated = false;
String userName = "";
int roleID = 0;
int userID = 0;

void setAuth(bool auth, String username, int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isAuthenticated = auth;
  userName = username;
  userID = id;

  if (userName.isNotEmpty) {
    var userinfo = await fetchUserInfo();
    await prefs.setInt("role", userinfo.first['idRol']);
    await prefs.setBool("Auth", auth);
    await prefs.setString("userName", username);
    await prefs.setInt("userID", userID);
  } else {
    await prefs.setInt("role", 0);
    await prefs.setBool("Auth", auth);
    await prefs.setString("userName", '');
    await prefs.setInt("userID", userID);
  }

  print(
      "PREFERENCES SET! -> ROLE ID: $roleID USERNAME: $userName ISAUTH? $isAuthenticated USER ID? $userID");
  print(roleID.toString());
}

void clearPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove("Auth");
  prefs.remove("userName");
  prefs.remove("role");
  prefs.remove("userID");
}

void reloadPref(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userinfo;

  isAuthenticated = prefs.getBool('Auth')!;
  userID = prefs.getInt('userID')!;

  if (userID > 0) {
    userinfo = await fetchUserInfo();
    var userFirst = userinfo.first;

    userName = userFirst['nick'];
    roleID = userFirst['idRol'];

    await prefs.setInt("role", roleID);
    await prefs.setString("userName", userName);
  } else {
    userName = prefs.getString('userName')!;
    roleID = prefs.getInt('role')!;
  }

  loadLateralMenu(context);

  print(
      "PREFERENCES RELOAD! -> ROLE ID: $roleID USERNAME: $userName ISAUTH? $isAuthenticated USER ID? $userID");
}

void setUsername(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userName = username;
  await prefs.setString("userName", username);
}

Future<Map<String, dynamic>> logOut() async {
  final response = await http.post(
    Uri.parse('$API_URI_SERVER/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

  print("GET USERS STATUS CODE: ${response.statusCode}");

  var responseData = response.body;
  var data = jsonDecode(responseData);
  print(data.toString());

  if (response.statusCode == 200) {
    clearPrefs();
    return {'success': true};
  } else {
    throw Exception('Failed to logout');
  }
}

Future<List<dynamic>> fetchUserInfo() async {
  print("USUARIO A CARGAR INFO: $userName con id: $userID");
  final response = await http.get(Uri.parse("$API_URI_SERVER/getUser/$userID"));

  print("STATUS CODE IS: ${response.statusCode}");
  print("ME DEVUELVE: ${response.body}");

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception(json.decode(response.body)['message']);
  }
}

void loadLateralMenu(context) {
  if (roleID == 0) {
    print("CARGANDO MENU LATERAL ANONIMO");
    welcomeMessage = const Text('');
    logOutListTitle = const SizedBox.shrink();
    shoppingCartListTitle = const SizedBox.shrink();
    profileListTitle = ListTile(
      leading: const Icon(Icons.account_circle,
          color: Color.fromARGB(255, 11, 214, 153)),
      title: const Text('Iniciar sessio'),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    );
  } else {
    print("CARGANDO MENU LATERAL USUARIO");
    welcomeMessage = Text(
      'Bienvenido $userName',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );
    logOutListTitle = ListTile(
        leading:
            const Icon(Icons.logout, color: Color.fromARGB(255, 11, 214, 153)),
        title: const Text('Tancar sessio'),
        onTap: () {
          logOut();
          setAuth(false, '', 0);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
    profileListTitle = ListTile(
      leading: const Icon(Icons.account_circle,
          color: Color.fromARGB(255, 11, 214, 153)),
      title: const Text('Perfil'),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      },
    );
    shoppingCartListTitle = ListTile(
      leading: const Icon(Icons.shopping_cart,
          color: Color.fromARGB(255, 11, 214, 153)),
      title: const Text('Cistell de compra'),
      onTap: () {
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => CardsPage()),
        );
      },
    );
  }
}
