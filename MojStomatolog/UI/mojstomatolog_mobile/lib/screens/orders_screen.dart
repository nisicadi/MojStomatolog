import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_mobile/enums/order_status.dart';
import 'package:mojstomatolog_mobile/models/order.dart';
import 'package:mojstomatolog_mobile/models/search/order_search.dart';
import 'package:mojstomatolog_mobile/providers/order_provider.dart';
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
    _initializeState();
  }

  void _initializeState() {
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
    setState(() {
      _isLoading = true;
      _currentPage = 1;
      _orders.clear();
    });

    try {
      var provider = OrderProvider();
      var searchObject = OrderSearchObject()
        ..page = _currentPage
        ..pageSize = _pageSize
        ..userId = User.userId;

      var searchResult = await provider.get(filter: searchObject.toJson());
      setState(() {
        _orders.addAll(searchResult.results);
        _currentPage++;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildCancelOrderButton(Order order) {
    if (order.status == OrderStatus.inProgress.index) {
      return ListTile(
        title: ElevatedButton(
          onPressed: () => _showCancelConfirmationDialog(order),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text(
            'Otkaži narudžbu',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Future<void> _cancelOrder(Order order) async {
    try {
      var response = await OrderProvider()
          .changeStatus(order.id!, OrderStatus.cancelled.index);
      if (response?.statusCode == 200) {
        setState(() {
          order.status = OrderStatus.cancelled.index;
        });
        _showSnackbar('Narudžba je otkazana.');
      } else {
        _showSnackbar('Greška pri otkazivanju narudžbe.');
      }
    } catch (e) {
      print(e);
      _showSnackbar('Greška pri otkazivanju narudžbe.');
    }
  }

  Future<void> _showCancelConfirmationDialog(Order order) async {
    bool? shouldCancel = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda otkazivanja narudžbe'),
          content: Text('Da li ste sigurni da želite otkazati ovu narudžbu?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Ne'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Da'),
            ),
          ],
        );
      },
    );

    if (shouldCancel != null && shouldCancel) {
      await _cancelOrder(order);
    }
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
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Narudžba #${order.id}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Datum: ${DateFormat('dd.MM.yyyy').format(order.orderDate ?? DateTime.now())}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Ukupni iznos: ${order.totalAmount} KM',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Status: ${_getStatusText(order.status!)}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 16.0),
                    _buildCancelOrderButton(order),
                    SizedBox(height: 16.0),
                    if (order.orderItems != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order.orderItems!
                            .map((item) => ListTile(
                                  title: Text(item.product?.name ?? 'Proizvod'),
                                  subtitle: Text('Količina: ${item.quantity}'),
                                  trailing: Text('Cijena: ${item.price} KM'),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: _isLoading ? CircularProgressIndicator() : null,
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'U obradi';
      case 1:
        return 'U tijeku';
      case 2:
        return 'Dostavljeno';
      case 3:
        return 'Otkazano';
      default:
        return 'Nepoznat status';
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
