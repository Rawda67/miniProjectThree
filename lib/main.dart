import 'package:flutter/material.dart';
import 'package:mini_poject3/view/LoginScreen.dart';
import 'package:mini_poject3/view/instgramScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Loginscreen());
  }
}
