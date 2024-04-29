import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//IP SERVIDOR -> 162.19.74.238:8080
//IP LOCAL PRUEBAS -> 10.1.85.13:8000

String API_URI_LOCAL = 'http://10.1.85.13:8000/api';
String API_URI_SERVER = 'http://162.19.74.238:8080/api';
String URI_SERVER_IMAGES = 'http://162.19.74.238:8080/images';

bool isAuthenticated = false;
String userName = "";

void setAuth(bool auth, String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isAuthenticated = auth;
  userName = username;

  prefs.setBool("Auth", auth);
  prefs.setString("userName", username);
}

void clearPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove("Auth");
  prefs.remove("userName");
}

void reloadPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isAuthenticated = prefs.getBool('Auth')!;
  userName = prefs.getString('userName')!;
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
  // Decodificar la respuesta JSON a un Map
  var data = jsonDecode(responseData);
  // Printear el resultado
  print(data.toString());

  if (response.statusCode == 200) {
    //Usuario ha cerrado la session correctamente
    return {'success': true};
  } else {
    // El usuario no se ha podido desconectar
    throw Exception('Failed to logout');
  }
}
