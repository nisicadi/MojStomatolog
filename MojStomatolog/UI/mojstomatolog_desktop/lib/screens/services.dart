import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/modals/add-service.dart';
import 'package:mojstomatolog_desktop/models/search/service_search.dart';
import 'package:mojstomatolog_desktop/models/service.dart';
import 'package:mojstomatolog_desktop/providers/service_provider.dart';
import 'dart:async';
import 'package:mojstomatolog_desktop/widgets/paginated_list_screen.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  final ServiceProvider _serviceProvider = ServiceProvider();
  List<Service> _services = [];
  int _currentPage = 1;
  int _totalCount = 0;
  String? _currentSearchTerm;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices({int page = 1, String? searchTerm}) async {
    try {
      var searchObject = ServiceSearchObject()
        ..page = page
        ..pageSize = 10
        ..searchTerm = searchTerm;

      final result = await _serviceProvider.get(filter: searchObject.toJson());
      setState(() {
        _services = result.results;
        _currentPage = page;
        _totalCount = result.count;
        _currentSearchTerm = searchTerm;
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  void _addOrUpdateService(Service service, {bool isUpdate = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddServiceModal(
          onServiceAdded: (newService) {
            _fetchServices(
              page: _currentPage,
              searchTerm: _currentSearchTerm,
            );
          },
          initialService: isUpdate ? service : null,
        );
      },
    );
  }

  void _searchServices(String searchTerm) {
    if (_searchTimer != null && _searchTimer!.isActive) {
      _searchTimer!.cancel();
    }

    _searchTimer = Timer(Duration(milliseconds: 300), () {
      _fetchServices(
        page: 1,
        searchTerm: searchTerm,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Naziv usluge')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _services.map((service) {
      return DataRow(
        cells: [
          DataCell(Text(service.name ?? '')),
          DataCell(IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _addOrUpdateService(service, isUpdate: true),
          )),
          DataCell(IconButton(
            icon: Icon(Icons.delete),
            onPressed: () =>
                _showDeleteConfirmationDialog(context, service.id!),
          )),
        ],
      );
    }).toList();

    return PageableListScreen(
      currentPage: 'Usluge',
      columns: columns,
      rows: rows,
      addButtonCallback: () => _addOrUpdateService(Service()),
      searchCallback: _searchServices,
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchServices(
        page: newPage,
        searchTerm: _currentSearchTerm,
      ),
      currentPageIndex: _currentPage,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int serviceId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content: Text('Jeste li sigurni da želite obrisati ovu uslugu?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _serviceProvider.delete(serviceId);
                _fetchServices(
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
