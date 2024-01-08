import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/modals/add-appointment.dart';
import 'package:mojstomatolog_desktop/models/appointment.dart';
import 'package:mojstomatolog_desktop/widgets/list_screen.dart';
import 'package:mojstomatolog_desktop/providers/appointment_provider.dart';

class AppointmentListScreen extends StatefulWidget {
  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  final AppointmentProvider _appointmentProvider = AppointmentProvider();
  late List<Appointment> _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = [];
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      final result = await _appointmentProvider.get();
      setState(() {
        _appointments = result.results;
      });
    } catch (e) {
      print("Error fetching appointments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Id')),
      DataColumn(label: Text('Datum')),
      DataColumn(label: Text('Procedura')),
      DataColumn(label: Text('Potvrđeno')),
      DataColumn(label: Text('Komentar')),
      DataColumn(label: Text('Detalji')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _appointments.map((appointment) {
      return DataRow(
        cells: [
          DataCell(Text(appointment.appointmentId.toString())),
          DataCell(Text(appointment.appointmentDateTime?.toString() ?? '')),
          DataCell(Text(appointment.procedure ?? '')),
          DataCell(Text(appointment.isConfirmed?.toString() ?? '')),
          DataCell(Text(appointment.notes ?? '')),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            _editAppointment(context, appointment);
          })),
          DataCell(_buildIconButton(Icons.delete, 'Briši', () {
            _showCancelConfirmationDialog(context, appointment.appointmentId!);
          })),
        ],
      );
    }).toList();

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

  Widget _buildIconButton(IconData icon, String tooltip, Function onPressed) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: () => onPressed(),
      ),
    );
  }

  void _addAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAppointmentModal(
          onAppointmentAdded: (newAppointment) {
            _fetchAppointments(); // Refresh the list after adding a new appointment
          },
        );
      },
    );
  }

  void _editAppointment(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAppointmentModal(
          onAppointmentAdded: (newAppointment) {
            _fetchAppointments(); // Refresh the list after editing an appointment
          },
          initialAppointment: appointment,
        );
      },
    );
  }

  void _searchAppointments(String searchTerm) {
    // Search logic with the provided search term
  }

  void _showFilterModal(BuildContext context) {
    // Filter modal logic
  }

  void _showCancelConfirmationDialog(BuildContext context, int appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda otkazivanja'),
          content: Text('Jeste li sigurni da želite obrisati ovaj termin?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _appointmentProvider.delete(appointmentId);
                _fetchAppointments(); // Refresh the list after deletion
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
