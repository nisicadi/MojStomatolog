import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/models/product.dart';
import 'package:mojstomatolog_desktop/widgets/list_screen.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductProvider _productProvider = ProductProvider();
  late List<Product> _products;

  @override
  void initState() {
    super.initState();
    _products = [];
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final result = await _productProvider.get();
      setState(() {
        _products = result.results;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Ime')),
      DataColumn(label: Text('Opis')),
      DataColumn(label: Text('Kategorija')),
      DataColumn(label: Text('Cijena')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _products.map((product) {
      return DataRow(
        cells: [
          DataCell(Text(product.productId.toString())),
          DataCell(Text(product.name ?? '')),
          DataCell(Text(product.description ?? '')),
          DataCell(Text(product.category ?? '')),
          DataCell(Text(product.price?.toString() ?? '')),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            // Edit button logic
          })),
          DataCell(_buildIconButton(Icons.delete, 'Briši', () {
            _showDeleteConfirmationDialog(context, product.productId!);
          })),
        ],
      );
    }).toList();

    return ListScreen(
      currentPage: 'Proizvodi',
      columns: columns,
      rows: rows,
      addButtonCallback: () {
        _addProduct(context);
      },
      searchCallback: (value) {
        _searchProducts(value);
      },
      filterButtonCallback: () {
        _showFilterModal(context);
      },
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, Function onPressed) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: () => onPressed(),
      ),
    );
  }

  void _addProduct(BuildContext context) {
    // Add product logic
  }

  void _searchProducts(String searchTerm) {
    // Search logic with the provided search term
  }

  void _showDeleteConfirmationDialog(BuildContext context, int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content: Text('Jeste li sigurni da želite obrisati ovaj proizvod?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _productProvider.delete(productId);
                _fetchProducts(); // Refresh the list after deletion
                Navigator.of(context).pop();
              },
              child: Text('Da'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ne'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterModal(BuildContext context) {
    // Implement filter logic for products
  }
}
