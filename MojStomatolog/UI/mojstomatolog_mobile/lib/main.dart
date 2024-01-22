import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mojstomatolog_mobile/screens/login_screen.dart';

final LocalStorage localStorage = new LocalStorage('localstorage');

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyMaterialApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
