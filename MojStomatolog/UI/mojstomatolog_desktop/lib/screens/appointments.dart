import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/widgets/list_screen.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Datum')),
      DataColumn(label: Text('Pacijent')),
      DataColumn(label: Text('Doktor')),
      DataColumn(label: Text('Status')),
      DataColumn(label: Text('Detalji')),
      DataColumn(label: Text('Otkaži')),
    ];

    final List<DataRow> rows = List.generate(
      2,
      (index) {
        final appointmentId = 'ID $index';
        final appointmentDate = 'Date $index';
        final patientName = 'Patient $index';
        final doctorName = 'Doctor $index';
        final appointmentStatus = 'Status $index';
        final isOddRow = index.isOdd;

        return DataRow(
          color: isOddRow ? MaterialStateProperty.all(Colors.grey[200]) : null,
          cells: [
            DataCell(Text(appointmentId)),
            DataCell(Text(appointmentDate)),
            DataCell(Text(patientName)),
            DataCell(Text(doctorName)),
            DataCell(Text(appointmentStatus)),
            DataCell(Text('Details')),
            DataCell(Text('Cancel')),
          ],
        );
      },
    );

    return ListScreen(
      currentPage: 'Termini',
      columns: columns,
      rows: rows,
      addButtonCallback: () {
        _addAppointment(context);
      },
      searchCallback: (value) {
        _searchAppointments(value);
      },
      filterButtonCallback: () {
        _showFilterModal(context);
      },
    );
  }

  void _addAppointment(BuildContext context) {
    // Add appointment logic
  }

  void _searchAppointments(String searchTerm) {
    // Search logic with the provided search term
  }

  void _showFilterModal(BuildContext context) {
    // Filter modal logic
  }
}
