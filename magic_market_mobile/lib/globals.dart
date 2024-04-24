import 'package:shared_preferences/shared_preferences.dart';

//IP SERVIDOR -> 162.19.74.238:8080
//IP LOCAL PRUEBAS -> 10.1.85.13:8000

String API_URI_LOCAL = 'http://10.1.85.13:8000/api';
String API_URI_SERVER = 'http://162.19.74.238:8080/api';

bool isAuthenticated = false;
String userName = "";

void setAuth(bool auth, String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isAuthenticated = auth;
  prefs.setBool("Auth", auth);
}