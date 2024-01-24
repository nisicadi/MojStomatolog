import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/product.dart';
import 'package:mojstomatolog_mobile/providers/product_provider.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';
import 'package:mojstomatolog_mobile/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductProvider productProvider = ProductProvider();
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = [];
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var result = await productProvider.get();
      setState(() {
        products = result.results;
      });
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  Future<void> _refreshData() async {
    try {
      var refreshedData = await productProvider.get();
      setState(() {
        products = refreshedData.results;
      });
    } catch (error) {
      print('Error refreshing data: $error');
    }
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
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt_rounded),
                  onPressed: () {
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
