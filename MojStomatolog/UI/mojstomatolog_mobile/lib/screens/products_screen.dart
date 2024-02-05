import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/modals/filter_products.dart';
import 'package:mojstomatolog_mobile/models/product.dart';
import 'package:mojstomatolog_mobile/models/search/product_search.dart';
import 'package:mojstomatolog_mobile/providers/product_provider.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';
import 'package:mojstomatolog_mobile/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductProvider productProvider = ProductProvider();
  List<Product> products = [];
  int currentPage = 1;
  String? searchTerm;
  double? priceFrom;
  double? priceTo;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  final int pageSize = 10;
  final int searchDebounceMilliseconds = 250;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadData() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      var searchObject = ProductSearchObject()
        ..isActive = true
        ..page = currentPage
        ..pageSize = pageSize
        ..searchTerm = searchTerm
        ..priceFrom = priceFrom
        ..priceTo = priceTo;

      var result = await productProvider.get(filter: searchObject.toJson());
      setState(() {
        products.addAll(result.results);
        currentPage++;
      });
    } catch (error) {
      print('Error loading data: $error');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<void> _refreshData() async {
    currentPage = 1;
    products.clear();
    await _loadData();
  }

  void _onSearchTextChanged(String text) {
    if (_debounce != null && _debounce!.isActive) {
      _debounce!.cancel();
    }
    _debounce = Timer(Duration(milliseconds: searchDebounceMilliseconds), () {
      setState(() {
        searchTerm = text;
      });
      _refreshData();
    });
  }

  void _applyFilters(double? priceFrom, double? priceTo) {
    setState(() {
      this.priceFrom = priceFrom;
      this.priceTo = priceTo;
    });
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pretraži',
                    ),
                    onChanged: _onSearchTextChanged,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt_rounded),
                  onPressed: () {
                    _showFilterModal(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
                controller: _scrollController,
              ),
            ),
          ),
          if (isLoading) CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilterModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductFilterModal(
          initialPriceFrom: priceFrom,
          initialPriceTo: priceTo,
          onFilter: _applyFilters,
        );
      },
    );
  }
}
