import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Postavke',
      child: Container(
        child: const Column(
          children: [
            Text('Postavke'),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
