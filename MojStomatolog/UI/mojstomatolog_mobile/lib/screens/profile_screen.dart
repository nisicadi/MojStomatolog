import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 3,
      child: Text("Profil"),
    );
  }
}
