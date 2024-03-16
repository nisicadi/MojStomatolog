import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mojstomatolog_desktop/modals/add-employee.dart';
import 'package:mojstomatolog_desktop/modals/filter-employees.dart';
import 'package:mojstomatolog_desktop/models/employee.dart';
import 'package:mojstomatolog_desktop/models/search/employee_search.dart';
import 'package:mojstomatolog_desktop/providers/employee_provider.dart';
import 'package:mojstomatolog_desktop/widgets/paginated_list_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final EmployeeProvider _employeeProvider = EmployeeProvider();
  List<Employee> _employees = [];
  int _currentPage = 1;
  int _totalCount = 0;
  String? _currentSearchTerm;
  DateTime? _currentDateFrom;
  DateTime? _currentDateTo;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees(
      {int page = 1,
      String? searchTerm,
      DateTime? dateFrom,
      DateTime? dateTo}) async {
    try {
      var searchObject = EmployeeSearchObject()
        ..page = page
        ..pageSize = 10
        ..searchTerm = searchTerm
        ..dateFrom = dateFrom
        ..dateTo = dateTo;

      final result = await _employeeProvider.get(filter: searchObject.toJson());
      setState(() {
        _employees = result.results;
        _currentPage = page;
        _totalCount = result.count;
        _currentSearchTerm = searchTerm;
        _currentDateFrom = dateFrom;
        _currentDateTo = dateTo;
      });
    } catch (e) {
      print("Error fetching employees: $e");
    }
  }

  void _addOrUpdateEmployee(Employee employee, {bool isUpdate = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeModal(
          onEmployeeAdded: (updatedEmployee) {
            _fetchEmployees(
              page: _currentPage,
              searchTerm: _currentSearchTerm,
              dateFrom: _currentDateFrom,
              dateTo: _currentDateTo,
            );
          },
          initialEmployee: isUpdate ? employee : null,
        );
      },
    );
  }

  void _searchEmployees(String searchTerm) {
    if (_searchTimer != null && _searchTimer!.isActive) {
      _searchTimer!.cancel();
    }

    _searchTimer = Timer(Duration(milliseconds: 300), () {
      _fetchEmployees(
        page: 1,
        searchTerm: searchTerm,
        dateFrom: _currentDateFrom,
        dateTo: _currentDateTo,
      );
    });
  }

  void _showFilterModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmployeeFilterModal(
          initialDateFrom: _currentDateFrom,
          initialDateTo: _currentDateTo,
          onFilter: (dateFrom, dateTo) {
            _fetchEmployees(
              page: 1,
              searchTerm: _currentSearchTerm,
              dateFrom: dateFrom,
              dateTo: dateTo,
            );
          },
        );
      },
    );
  }

  void _clearFilters() {
    _fetchEmployees(
      page: 1,
      searchTerm: null,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int employeeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content:
              Text('Jeste li sigurni da želite obrisati ovog zaposlenika?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _employeeProvider.delete(employeeId);
                _fetchEmployees(
                  page: _currentPage,
                  searchTerm: _currentSearchTerm,
                  dateFrom: _currentDateFrom,
                  dateTo: _currentDateTo,
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
      DataColumn(label: Text('Ime')),
      DataColumn(label: Text('Prezime')),
      DataColumn(label: Text('Pozicija')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _employees.map((employee) {
      return DataRow(
        cells: [
          DataCell(Text(employee.firstName ?? '')),
          DataCell(Text(employee.lastName ?? '')),
          DataCell(Text(employee.specialization ?? '')),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            _addOrUpdateEmployee(employee, isUpdate: true);
          })),
          DataCell(_buildIconButton(Icons.delete, 'Briši', () {
            _showDeleteConfirmationDialog(context, employee.employeeId!);
          })),
        ],
      );
    }).toList();

    return PageableListScreen(
      currentPage: 'Uposlenici',
      columns: columns,
      rows: rows,
      addButtonCallback: () => _addOrUpdateEmployee(Employee()),
      searchCallback: (value) => _searchEmployees(value),
      filterButtonCallback: () => _showFilterModal(),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchEmployees(
        page: newPage,
        searchTerm: _currentSearchTerm,
        dateFrom: _currentDateFrom,
        dateTo: _currentDateTo,
      ),
      currentPageIndex: _currentPage,
    );
  }
}
