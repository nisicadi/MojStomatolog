import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mojstomatolog_desktop/modals/add-product.dart';
import 'package:mojstomatolog_desktop/modals/filter-products.dart';
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
  double? _currentPriceFrom;
  double? _currentPriceTo;
  bool? _currentIsActive;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts(
      {int page = 1,
      String? searchTerm,
      double? priceFrom,
      double? priceTo,
      bool? isActive}) async {
    try {
      var searchObject = ProductSearchObject()
        ..page = page
        ..pageSize = 10
        ..searchTerm = searchTerm
        ..priceFrom = priceFrom
        ..priceTo = priceTo
        ..isActive = isActive;

      final result = await _productProvider.get(filter: searchObject.toJson());
      setState(() {
        _products = result.results;
        _currentPage = page;
        _totalCount = result.count;
        _currentSearchTerm = searchTerm;
        _currentPriceFrom = priceFrom;
        _currentPriceTo = priceTo;
        _currentIsActive = isActive;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void _addOrUpdateProduct(Product product, {bool isUpdate = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductModal(
          onProductAdded: (newProduct) {
            _fetchProducts(
              page: _currentPage,
              searchTerm: _currentSearchTerm,
              priceFrom: _currentPriceFrom,
              priceTo: _currentPriceTo,
              isActive: _currentIsActive,
            );
          },
          initialProduct: isUpdate ? product : null,
        );
      },
    );
  }

  void _searchProducts(String searchTerm) {
    if (_searchTimer != null && _searchTimer!.isActive) {
      _searchTimer!.cancel();
    }

    _searchTimer = Timer(Duration(milliseconds: 300), () {
      _fetchProducts(
        page: 1,
        searchTerm: searchTerm,
        priceFrom: _currentPriceFrom,
        priceTo: _currentPriceTo,
        isActive: _currentIsActive,
      );
    });
  }

  void _showFilterModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductFilterModal(
          initialPriceFrom: _currentPriceFrom,
          initialPriceTo: _currentPriceTo,
          initialIsActive: _currentIsActive,
          onFilter: (priceFrom, priceTo, isActive) {
            _fetchProducts(
              page: 1,
              searchTerm: _currentSearchTerm,
              priceFrom: priceFrom,
              priceTo: priceTo,
              isActive: isActive,
            );
          },
        );
      },
    );
  }

  void _clearFilters() {
    _fetchProducts(
      page: 1,
      searchTerm: null,
      priceFrom: null,
      priceTo: null,
      isActive: null,
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
          DataCell(ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 200),
            child: Text(
              product.description ?? '',
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          )),
          DataCell(Text(product.productCategory?.name ?? '')),
          DataCell(Text(product.price?.toString() ?? '')),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            _addOrUpdateProduct(product, isUpdate: true);
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
      addButtonCallback: () => _addOrUpdateProduct(Product()),
      searchCallback: (value) => _searchProducts(value),
      filterButtonCallback: () => _showFilterModal(),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchProducts(
        page: newPage,
        searchTerm: _currentSearchTerm,
        priceFrom: _currentPriceFrom,
        priceTo: _currentPriceTo,
        isActive: _currentIsActive,
      ),
      currentPageIndex: _currentPage,
    );
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
                _fetchProducts(
                  page: _currentPage,
                  searchTerm: _currentSearchTerm,
                  priceFrom: _currentPriceFrom,
                  priceTo: _currentPriceTo,
                  isActive: _currentIsActive,
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
