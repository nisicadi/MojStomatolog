import 'package:flutter/material.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  int currentIndex;

  MasterScreenWidget({Key? key, this.child, required this.currentIndex})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moj Stomatolog'),
        backgroundColor: Colors.black,
      ),
      body: widget.child!,
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
    setState(() {
      widget.currentIndex = index;
    });

    // TODO: Implement navigation logic
  }
}
