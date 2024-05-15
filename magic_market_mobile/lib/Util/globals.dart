import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//IP SERVIDOR -> 162.19.74.238:8080
//IP LOCAL PRUEBAS -> 10.1.85.13:8000

String API_URI_CASA = 'http://192.168.0.20:8000/api';
String API_URI_LOCAL = 'http://10.1.85.13:8000/api';
String API_URI_SERVER = 'http://162.19.74.238:8080/api';
String URI_SERVER_IMAGES = 'http://162.19.74.238:8080/images';

bool isAuthenticated = false;
String userName = "";
int roleID = 0;
int userID = 0;

void setAuth(bool auth, String username, int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isAuthenticated = auth;
  userName = username;
  userID = id;

  var userinfo = await fetchUserInfo();

  await prefs.setInt("role", userinfo['idRol']);
  await prefs.setBool("Auth", auth);
  await prefs.setString("userName", username);
  await prefs.setInt("userID", userID);

  print(roleID.toString());
}

void clearPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove("Auth");
  prefs.remove("userName");
  prefs.remove("role");
  prefs.remove("userID");
}

void reloadPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isAuthenticated = prefs.getBool('Auth')!;
  userName = prefs.getString('userName')!;
  roleID = prefs.getInt('role')!;
  userID = prefs.getInt('userID')!;

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

Future<Map<String, dynamic>> fetchUserInfo() async {
  print("USUARIO A CARGAR INFO: $userName");
  final response =
      await http.get(Uri.parse("$API_URI_SERVER/getUser?nickname=$userName"));

  print("STATUS CODE IS: ${response.statusCode}");
  print("ME DEVUELVE: ${response.body}");

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception(json.decode(response.body)['message']);
  }
}
