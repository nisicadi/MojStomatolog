import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Termini',
      child: Container(
        child: const Column(
          children: [
            Text('Termini'),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
