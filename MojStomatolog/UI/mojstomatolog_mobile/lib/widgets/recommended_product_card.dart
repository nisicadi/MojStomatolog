import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/product.dart';

class RecommendedProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  RecommendedProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.3;
    final double cardHeight = 250;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl ?? '',
                height: 120,
                width: cardWidth,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/no_image.jpg',
                    height: 120,
                    width: cardWidth,
                    fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(product.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
              ),
              Text('${product.price?.toStringAsFixed(2) ?? ''} KM'),
            ],
          ),
        ),
      ),
    );
  }
}
