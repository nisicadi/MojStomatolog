import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/screens/appointments_screen.dart';
import 'package:mojstomatolog_mobile/screens/news_screen.dart';
import 'package:mojstomatolog_mobile/screens/products_screen.dart';
import 'package:mojstomatolog_mobile/screens/profile_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget child;
  final int currentIndex;

  MasterScreenWidget(
      {Key? key, required this.child, required this.currentIndex})
      : super(key: key);

  @override
  _MasterScreenWidgetState createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moj Stomatolog'),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: widget.currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Početna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Termini',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Proizvodi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    if (index == widget.currentIndex) {
      return;
    }

    Widget nextPage;

    switch (index) {
      case 0:
        nextPage = NewsPage();
        break;
      case 1:
        nextPage = AppointmentsPage();
        break;
      case 2:
        nextPage = ProductsPage();
        break;
      case 3:
        nextPage = ProfilePage();
        break;
      default:
        nextPage = NewsPage();
    }

    Navigator.of(context).pushReplacement(_noAnimationRoute(nextPage));
  }

  Route _noAnimationRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero, // No animation duration
      reverseTransitionDuration: Duration.zero, // No reverse animation duration
    );
  }
}
