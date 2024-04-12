import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_market_mobile/dashaboard.dart';
import 'package:magic_market_mobile/register.dart';

import 'login.dart';

void main() {
  runApp(MyApp());
}

const bool isLoged = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "MAGIC MARKET ONLINE",
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
      redirect: (context, state) {
        if (isLoged) {
          return '/dashboard';
        }
        return '/login';
      },
      routes: [
        GoRoute(path: "/login", builder: (context, state) => const Login()),
        GoRoute(
            path: "/register", builder: (context, state) => const Register()),
        GoRoute(
            path: "/dashboard", builder: (context, state) => const Dashboard())
      ]);
}
