import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/modals/add-employee.dart';
import 'package:mojstomatolog_desktop/models/employee.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees({int page = 1}) async {
    try {
      var searchObject = BaseSearchObject();
      searchObject.page = page;
      searchObject.pageSize = 10;

      final result = await _employeeProvider.get(filter: searchObject.toJson());
      setState(() {
        _employees = result.results;
        _currentPage = page;
        _totalCount = result.count;
      });
    } catch (e) {
      print("Error fetching employees: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Ime')),
      DataColumn(label: Text('Prezime')),
      DataColumn(label: Text('Pozicija')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _employees.map((employee) {
      return DataRow(
        cells: [
          DataCell(Text(employee.employeeId.toString())),
          DataCell(Text(employee.firstName ?? '')),
          DataCell(Text(employee.lastName ?? '')),
          DataCell(Text(employee.specialization ?? '')),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            _editEmployee(context, employee);
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
      addButtonCallback: () => _addEmployee(context),
      searchCallback: (value) => _searchEmployees(value),
      filterButtonCallback: () => _showFilterModal(context),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchEmployees(page: newPage),
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

  void _addEmployee(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeModal(
          onEmployeeAdded: (newEmployee) {
            _fetchEmployees(); // Refresh the list after adding a new employee
          },
        );
      },
    );
  }

  void _editEmployee(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEmployeeModal(
          onEmployeeAdded: (updatedEmployee) {
            _fetchEmployees(); // Refresh the list after editing an employee
          },
          initialEmployee: employee,
        );
      },
    );
  }

  void _searchEmployees(String searchTerm) {
    // Search logic with the provided search term
  }

  void _showFilterModal(BuildContext context) {
    // Implement filter logic for employees
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
                _fetchEmployees(); // Refresh the list after deletion
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
