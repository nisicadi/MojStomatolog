import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Novosti',
      child: Container(
        child: const Column(
          children: [
            Text('Novosti'),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
