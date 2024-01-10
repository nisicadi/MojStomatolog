import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/modals/add-appointment.dart';
import 'package:mojstomatolog_desktop/models/appointment.dart';
import 'package:mojstomatolog_desktop/models/search/base_search.dart';
import 'package:mojstomatolog_desktop/providers/appointment_provider.dart';
import 'package:mojstomatolog_desktop/widgets/paginated_list_screen.dart';

class AppointmentListScreen extends StatefulWidget {
  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  final AppointmentProvider _appointmentProvider = AppointmentProvider();
  List<Appointment> _appointments = [];
  int _currentPage = 1;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments({int page = 1}) async {
    var searchObject = BaseSearchObject();
    searchObject.page = page;
    searchObject.pageSize = 10;

    final result =
        await _appointmentProvider.get(filter: searchObject.toJson());
    setState(() {
      _appointments = result.results;
      _currentPage = page;
      _totalCount = result.count;
    });
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
          DataCell(Text(DateFormat('dd.MM.yyyy  HH:mm')
              .format(appointment.appointmentDateTime ?? DateTime.now()))),
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

    return PageableListScreen(
      currentPage: 'Termini',
      columns: columns,
      rows: rows,
      addButtonCallback: () => _addAppointment(context),
      searchCallback: (value) => _searchAppointments(value),
      filterButtonCallback: () => _showFilterModal(context),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchAppointments(page: newPage),
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

  void _addAppointment(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAppointmentModal(
          onAppointmentAdded: (newAppointment) {
            _fetchAppointments();
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
            _fetchAppointments();
          },
          initialAppointment: appointment,
        );
      },
    );
  }

  void _searchAppointments(String searchTerm) {
    // Implement search logic
  }

  void _showFilterModal(BuildContext context) {
    // Implement filter modal logic
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
                _fetchAppointments();
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
