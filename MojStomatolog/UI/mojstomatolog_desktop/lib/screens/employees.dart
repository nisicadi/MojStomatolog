import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/list_screen.dart';

class EmployeeListScreen extends StatelessWidget {
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

    final List<DataRow> rows = List.generate(
      2,
      (index) {
        final employeeId = 'ID $index';
        final firstName = 'Ime $index';
        final lastName = 'Prezime $index';
        final position = 'Pozicija $index';
        final isOddRow = index.isOdd;

        return DataRow(
          color: isOddRow ? MaterialStateProperty.all(Colors.grey[200]) : null,
          cells: [
            DataCell(Text(employeeId)),
            DataCell(Text(firstName)),
            DataCell(Text(lastName)),
            DataCell(Text(position)),
            DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
              // Edit button logic
            })),
            DataCell(_buildIconButton(Icons.delete, 'Briši', () {
              _showDeleteConfirmationDialog(context);
            })),
          ],
        );
      },
    );

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
    // Add employee logic
  }

  void _searchEmployees(String searchTerm) {
    // Search logic with the provided search term
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content:
              Text('Jeste li sigurni da želite obrisati ovog zaposlenika?'),
          actions: [
            TextButton(
              onPressed: () {
                // Delete logic here
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

  void _showFilterModal(BuildContext context) {
    // Implement filter logic for employees
  }
}
