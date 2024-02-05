import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/product.dart';
import 'package:mojstomatolog_mobile/screens/product_details.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl ?? '',
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/no_image.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Cijena: ${product.price} KM'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
