import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/list_screen.dart';

class ProductListScreen extends StatelessWidget {
  double minPrice = 0.0;
  double maxPrice = 100.0;
  DateTime? minDate;
  DateTime? maxDate;

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Šifra')),
      DataColumn(label: Text('Naziv')),
      DataColumn(label: Text('Slika')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = List.generate(
      2,
      (index) {
        final productId = 'ID $index';
        final productCode = 'Code $index';
        final productName = 'Name $index';
        final productImage = 'Image $index';
        final isOddRow = index.isOdd;

        return DataRow(
          color: isOddRow ? MaterialStateProperty.all(Colors.grey[200]) : null,
          cells: [
            DataCell(Text(productId)),
            DataCell(Text(productCode)),
            DataCell(Text(productName)),
            DataCell(Text(productImage)),
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
      currentPage: 'Proizvodi',
      columns: columns,
      rows: rows,
      addButtonCallback: () {
        _addProduct(context);
      },
      searchCallback: (value) {
        _searchProducts(value);
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

  void _addProduct(BuildContext context) {
    // Add product logic
  }

  void _searchProducts(String searchTerm) {
    // Search logic with the provided search term
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content: Text('Jeste li sigurni da želite obrisati ovaj proizvod?'),
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

  void _showFilterModal(BuildContext context) {}
}
