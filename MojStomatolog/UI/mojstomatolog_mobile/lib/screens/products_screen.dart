import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 2,
      child: Text("Proizvodi"),
    );
  }
}
