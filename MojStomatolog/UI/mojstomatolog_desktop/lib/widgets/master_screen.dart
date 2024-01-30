import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/screens/appointments.dart';
import 'package:mojstomatolog_desktop/screens/articles.dart';
import 'package:mojstomatolog_desktop/screens/employees.dart';
import 'package:mojstomatolog_desktop/screens/login_screen.dart';
import 'package:mojstomatolog_desktop/screens/product_categories.dart';
import 'package:mojstomatolog_desktop/screens/product_list_screen.dart';
import 'package:mojstomatolog_desktop/screens/settings.dart';
import 'package:mojstomatolog_desktop/providers/user_provider.dart';

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
            buildButton('Kategorije proizvoda'),
            buildButton('Članci'),
            buildButton('Postavke'),
            Spacer(),
            buildLogoutButton(),
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

  Widget buildLogoutButton() {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 20),
        ),
        child: Text(
          'Logout',
          style: const TextStyle(
            fontSize: 19.0,
          ),
        ),
        onPressed: () {
          handleLogout();
        },
      ),
    );
  }

  void handleLogout() {
    UserProvider().logOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
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
      case 'Kategorije proizvoda':
        screen = ProductCategoryListScreen();
        break;
      case 'Članci':
        screen = ArticleListScreen();
        break;
      case 'Postavke':
        screen = SettingsScreen();
        break;
      default:
        throw Exception("Invalid page name: $pageName");
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var tween = Tween(begin: begin, end: end);
          var fadeAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 150),
      ),
    );
  }
}
