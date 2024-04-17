import 'package:shared_preferences/shared_preferences.dart';

String API_URI_LOCAL = 'http://10.1.85.13:8000/api';
String API_URI_SERVER = 'http://162.19.74.238:8080/api';

bool isAuthenticated = false;

void setAuth(bool auth) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey("Auth")) {
    prefs.setBool("Auth", auth);
  } else {
    throw Exception('Auth var does not exist...');
  }
}

//IP SERVIDOR -> 162.19.74.238:8080
//IP LOCAL PRUEBAS -> 10.1.85.13:8000


