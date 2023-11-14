import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Uposlenici',
      child: Text('Details'),
    );
  }
}
