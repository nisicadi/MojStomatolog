import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/order.dart';
import 'package:mojstomatolog_mobile/models/search/order_search.dart';
import 'package:mojstomatolog_mobile/providers/order_provider.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadOrders({bool refresh = false}) async {
    if (_isLoading && !refresh) return;
    setState(() => _isLoading = true);

    if (refresh) {
      _currentPage = 1;
      _orders.clear();
    }

    try {
      var provider = OrderProvider();
      var searchObject = OrderSearchObject()
        ..page = _currentPage
        ..pageSize = _pageSize
        ..userId = User.userId;

      var searchResult = await provider.get(filter: searchObject.toJson());
      setState(() {
        _orders.addAll(searchResult.results);
        if (!refresh) {
          _currentPage++;
        }
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadOrders();
    }
  }

  Future<void> _refreshList() async {
    await _loadOrders(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Narudžbe'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _orders.length,
          itemBuilder: (BuildContext context, int index) {
            Order order = _orders[index];
            return Card(
              child: ExpansionTile(
                title: Text('Narudžba #${order.id}'),
                subtitle: Text('Ukupni iznos: ${order.totalAmount} KM'),
                trailing: Text(
                  'Datum: ${DateFormat('dd.MM.yyyy').format(order.orderDate ?? DateTime.now())}',
                ),
                children: order.orderItems
                        ?.map((item) => ListTile(
                              title: Text(item.product?.name ?? 'Proizvod'),
                              subtitle: Text('Količina: ${item.quantity}'),
                              trailing: Text('Cijena: ${item.price} KM'),
                            ))
                        .toList() ??
                    [],
              ),
            );
          },
        ),
      ),
      floatingActionButton: _isLoading ? CircularProgressIndicator() : null,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
