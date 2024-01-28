import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/product.dart';

class RecommendedProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  RecommendedProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Image.network(
              product.imageUrl ?? '',
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/images/no_image.jpg', height: 120),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(product.name ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text('${product.price?.toStringAsFixed(2) ?? ''} KM'),
          ],
        ),
      ),
    );
  }
}
