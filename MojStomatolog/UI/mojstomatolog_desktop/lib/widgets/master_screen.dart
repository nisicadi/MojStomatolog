import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/screens/appointments.dart';
import 'package:mojstomatolog_desktop/screens/employees.dart';
import 'package:mojstomatolog_desktop/screens/news.dart';
import 'package:mojstomatolog_desktop/screens/product_list_screen.dart';
import 'package:mojstomatolog_desktop/screens/settings.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final String currentPage;

  MasterScreenWidget({Key? key, this.child, required this.currentPage})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildButton('Uposlenici'),
            buildButton('Termini'),
            buildButton('Proizvodi'),
            buildButton('Novosti'),
            buildButton('Postavke'),
          ],
        ),
      ),
      body: widget.child!,
    );
  }

  Widget buildButton(String pageName) {
    final bool isActive = widget.currentPage == pageName;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? Colors.grey[300]! : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: isActive ? Colors.grey[200] : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20),
        ),
        child: Text(
          pageName,
          style: const TextStyle(
            fontSize: 19.0,
          ),
        ),
        onPressed: () {
          if (widget.currentPage != pageName) {
            navigateToPage(pageName);
          }
        },
      ),
    );
  }

  void navigateToPage(String pageName) {
    Widget screen;
    switch (pageName) {
      case 'Uposlenici':
        screen = EmployeeListScreen();
        break;
      case 'Termini':
        screen = AppointmentListScreen();
        break;
      case 'Proizvodi':
        screen = ProductListScreen();
        break;
      case 'Novosti':
        screen = NewsScreen();
        break;
      case 'Postavke':
        screen = SettingsScreen();
        break;
      default:
        throw Exception("Invalid page name: $pageName");
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}