import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mojstomatolog_mobile/screens/login_screen.dart';

final LocalStorage localStorage = new LocalStorage('localstorage');

void main() {
  runApp(const MyMaterialApp());
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moj stomatolog',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: LoginPage(),
    );
  }
}
