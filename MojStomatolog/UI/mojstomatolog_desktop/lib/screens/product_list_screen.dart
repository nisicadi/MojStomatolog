import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/screens/product_details.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Proizvodi',
      child: Container(
        child: Column(
          children: [
            Text('Product list'),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProductDetailScreen(),
                    ),
                  );
                },
                child: Text('Click'))
          ],
        ),
      ),
    );
  }
}
