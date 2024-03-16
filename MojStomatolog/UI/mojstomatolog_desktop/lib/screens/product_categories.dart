import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/modals/add-product-category.dart';
import 'dart:async';
import 'package:mojstomatolog_desktop/models/product_category.dart';
import 'package:mojstomatolog_desktop/models/search/product_category_search.dart';
import 'package:mojstomatolog_desktop/providers/product_category_provider.dart';
import 'package:mojstomatolog_desktop/widgets/paginated_list_screen.dart';

class ProductCategoryListScreen extends StatefulWidget {
  @override
  _ProductCategoryListScreenState createState() =>
      _ProductCategoryListScreenState();
}

class _ProductCategoryListScreenState extends State<ProductCategoryListScreen> {
  final ProductCategoryProvider _categoryProvider = ProductCategoryProvider();
  List<ProductCategory> _categories = [];
  int _currentPage = 1;
  int _totalCount = 0;
  String? _currentSearchTerm;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories({int page = 1, String? searchTerm}) async {
    try {
      var searchObject = ProductCategorySearchObject()
        ..page = page
        ..pageSize = 10
        ..searchTerm = searchTerm;

      final result = await _categoryProvider.get(filter: searchObject.toJson());
      setState(() {
        _categories = result.results;
        _currentPage = page;
        _totalCount = result.count;
        _currentSearchTerm = searchTerm;
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void _addOrUpdateCategory(ProductCategory category, {bool isUpdate = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductCategoryModal(
          onCategoryAdded: (newCategory) {
            _fetchCategories(
              page: _currentPage,
              searchTerm: _currentSearchTerm,
            );
          },
          initialCategory: isUpdate ? category : null,
        );
      },
    );
  }

  void _searchCategories(String searchTerm) {
    if (_searchTimer != null && _searchTimer!.isActive) {
      _searchTimer!.cancel();
    }

    _searchTimer = Timer(Duration(milliseconds: 300), () {
      _fetchCategories(
        page: 1,
        searchTerm: searchTerm,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Naziv')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _categories.map((category) {
      return DataRow(
        cells: [
          DataCell(Text(category.name ?? '')),
          DataCell(IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _addOrUpdateCategory(category, isUpdate: true),
          )),
          DataCell(IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmationDialog(
                context, category.productCategoryId!),
          )),
        ],
      );
    }).toList();

    return PageableListScreen(
      currentPage: 'Kategorije proizvoda',
      columns: columns,
      rows: rows,
      addButtonCallback: () => _addOrUpdateCategory(ProductCategory()),
      searchCallback: _searchCategories,
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchCategories(
        page: newPage,
        searchTerm: _currentSearchTerm,
      ),
      currentPageIndex: _currentPage,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int categoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content: Text('Jeste li sigurni da želite obrisati ovu kategoriju?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _categoryProvider.delete(categoryId);
                _fetchCategories(
                  page: _currentPage,
                  searchTerm: _currentSearchTerm,
                );
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
