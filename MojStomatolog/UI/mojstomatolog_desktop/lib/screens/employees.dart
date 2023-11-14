import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Uposlenici',
      child: Container(
        child: const Column(
          children: [
            Text('Uposlenici'),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
