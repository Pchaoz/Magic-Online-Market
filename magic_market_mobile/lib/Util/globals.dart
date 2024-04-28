import 'package:shared_preferences/shared_preferences.dart';

//IP SERVIDOR -> 162.19.74.238:8080
//IP LOCAL PRUEBAS -> 10.1.85.13:8000

String API_URI_LOCAL = 'http://10.1.85.13:8000/api';
String API_URI_SERVER = 'http://162.19.74.238:8080/api';
String URI_SERVER_IMAGES = 'http://162.19.74.238:8080/images/';

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
