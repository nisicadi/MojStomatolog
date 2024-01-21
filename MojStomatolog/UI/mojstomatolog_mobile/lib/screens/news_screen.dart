import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 0,
      child: Text("Pocetna"),
    );
  }
}
