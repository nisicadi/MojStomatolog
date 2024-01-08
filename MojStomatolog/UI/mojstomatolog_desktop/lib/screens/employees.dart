import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/modals/add-employee.dart';
import 'package:mojstomatolog_desktop/models/employee.dart';
import 'package:mojstomatolog_desktop/widgets/list_screen.dart';
import 'package:mojstomatolog_desktop/providers/employee_provider.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final EmployeeProvider _employeeProvider = EmployeeProvider();
  late List<Employee> _employees;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    try {
      final result = await _employeeProvider.get();
      setState(() {
        _employees = result.results;
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

    return ListScreen(
      currentPage: 'Uposlenici',
      columns: columns,
      rows: rows,
      addButtonCallback: () {
        _addEmployee(context);
      },
      searchCallback: (value) {
        _searchEmployees(value);
      },
      filterButtonCallback: () {
        _showFilterModal(context);
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
