import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/product.dart';
import 'package:mojstomatolog_mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? 'Detalji proizvoda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                product.imageUrl ?? '',
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/no_image.jpg'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              'Opis:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(product.description ?? 'Nema opisa'),
            SizedBox(height: 8),
            Text(
              'Kategorija: ${product.category ?? 'N/A'}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              'Cijena: ${product.price?.toStringAsFixed(2) ?? ''} KM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(product);

                Navigator.pop(context);
              },
              child: Text(
                'Dodaj u korpu',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
