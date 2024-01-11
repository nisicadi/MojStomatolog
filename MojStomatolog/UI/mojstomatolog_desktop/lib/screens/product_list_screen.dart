import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mojstomatolog_desktop/modals/add-product.dart';
import 'package:mojstomatolog_desktop/models/product.dart';
import 'package:mojstomatolog_desktop/models/search/product_search.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';
import 'package:mojstomatolog_desktop/widgets/paginated_list_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductProvider _productProvider = ProductProvider();
  List<Product> _products = [];
  int _currentPage = 1;
  int _totalCount = 0;
  String? _currentSearchTerm;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts({int page = 1, String? searchTerm}) async {
    try {
      var searchObject = ProductSearchObject();
      searchObject.page = page;
      searchObject.pageSize = 10;
      searchObject.searchTerm = searchTerm;

      final result = await _productProvider.get(filter: searchObject.toJson());
      setState(() {
        _products = result.results;
        _currentPage = page;
        _totalCount = result.count;
        _currentSearchTerm = searchTerm;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Naziv')),
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
            _editProduct(context, product);
          })),
          DataCell(_buildIconButton(Icons.delete, 'Briši', () {
            _showDeleteConfirmationDialog(context, product.productId!);
          })),
        ],
      );
    }).toList();

    return PageableListScreen(
      currentPage: 'Proizvodi',
      columns: columns,
      rows: rows,
      addButtonCallback: () => _addProduct(context),
      searchCallback: (value) => _searchProducts(value),
      filterButtonCallback: () => _showFilterModal(context),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchProducts(page: newPage, searchTerm: _currentSearchTerm),
      currentPageIndex: _currentPage,
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductModal(
          onProductAdded: (newProduct) {
            _fetchProducts();
          },
        );
      },
    );
  }

  void _editProduct(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductModal(
          onProductAdded: (updatedProduct) {
            _fetchProducts();
          },
          initialProduct: product,
        );
      },
    );
  }

  void _searchProducts(String searchTerm) {
    if (_searchTimer != null && _searchTimer!.isActive) {
      _searchTimer!.cancel();
    }

    _searchTimer = Timer(Duration(milliseconds: 500), () {
      if (searchTerm.isEmpty) {
        _fetchProducts();
      } else {
        _fetchProducts(searchTerm: searchTerm);
      }
    });
  }

  void _showFilterModal(BuildContext context) {
    // Implement filter modal logic
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
                _fetchProducts(page: _currentPage, searchTerm: _currentSearchTerm);
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
}
