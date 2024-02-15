import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mojstomatolog_mobile/providers/cart_provider.dart';
import 'package:mojstomatolog_mobile/screens/login_screen.dart';
import 'package:provider/provider.dart';

final LocalStorage localStorage = new LocalStorage('localstorage');

void main() {
  HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey = const String.fromEnvironment("stripePublishableKey",
      defaultValue:
          "pk_test_51OcsSjKDEaPbMijSiXrYx8HDkUNgZGLbnOeHEQesnksSzGdDETP4gHtbjOINGDid2qVHihfSCXGQYPi466DTrPrn00FyG54N1p");

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyMaterialApp(),
    ),
  );
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
      debugShowCheckedModeBanner: false,
    );
  }
}
