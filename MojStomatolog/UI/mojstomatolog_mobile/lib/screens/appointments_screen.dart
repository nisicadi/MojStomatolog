import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 1,
      child: Text("Termini"),
    );
  }
}
