import 'package:flutter/material.dart';
import 'package:resto_finder/screens/splash_screen.dart';

import 'screens/login.dart';
var w;
var h;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    w= MediaQuery.of(context).size.width;
    h= MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}