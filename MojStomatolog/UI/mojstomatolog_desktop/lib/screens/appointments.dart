import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:mojstomatolog_desktop/modals/add-appointment.dart';
import 'package:mojstomatolog_desktop/modals/filter-appointments.dart';
import 'package:mojstomatolog_desktop/models/appointment.dart';
import 'package:mojstomatolog_desktop/models/search/appointment_search.dart';
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
  String? _currentSearchTerm;
  DateTime? _currentDateFrom;
  DateTime? _currentDateTo;
  bool? _currentIsConfirmed;
  Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments(
      {int page = 1,
      String? searchTerm,
      DateTime? dateFrom,
      DateTime? dateTo,
      bool? isConfirmed}) async {
    try {
      var searchObject = AppointmentSearchObject()
        ..page = page
        ..pageSize = 10
        ..searchTerm = searchTerm
        ..dateTimeFrom = dateFrom
        ..dateTimeTo = dateTo
        ..isConfirmed = isConfirmed;

      final result =
          await _appointmentProvider.get(filter: searchObject.toJson());
      setState(() {
        _appointments = result.results;
        _currentPage = page;
        _totalCount = result.count;
        _currentSearchTerm = searchTerm;
        _currentDateFrom = dateFrom;
        _currentDateTo = dateTo;
        _currentIsConfirmed = isConfirmed;
      });
    } catch (e) {
      print("Error fetching appointments: $e");
    }
  }

  void _addOrUpdateAppointment(Appointment appointment,
      {bool isUpdate = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAppointmentModal(
          onAppointmentAdded: (newAppointment) {
            _fetchAppointments(
              page: _currentPage,
              searchTerm: _currentSearchTerm,
              dateFrom: _currentDateFrom,
              dateTo: _currentDateTo,
              isConfirmed: _currentIsConfirmed,
            );
          },
          initialAppointment: isUpdate ? appointment : null,
        );
      },
    );
  }

  void _searchAppointments(String searchTerm) {
    if (_searchTimer != null && _searchTimer!.isActive) {
      _searchTimer!.cancel();
    }

    _searchTimer = Timer(Duration(milliseconds: 300), () {
      _fetchAppointments(
        page: 1,
        searchTerm: searchTerm,
        dateFrom: _currentDateFrom,
        dateTo: _currentDateTo,
        isConfirmed: _currentIsConfirmed,
      );
    });
  }

  void _showFilterModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AppointmentFilterModal(
          initialDateFrom: _currentDateFrom,
          initialDateTo: _currentDateTo,
          initialIsConfirmed: _currentIsConfirmed,
          onFilter: (dateFrom, dateTo, isConfirmed) {
            _fetchAppointments(
              page: 1,
              searchTerm: _currentSearchTerm,
              dateFrom: dateFrom,
              dateTo: dateTo,
              isConfirmed: isConfirmed,
            );
          },
        );
      },
    );
  }

  void _clearFilters() {
    _fetchAppointments(
      page: 1,
      searchTerm: null,
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
      DataColumn(label: Text('Datum i vrijeme')),
      DataColumn(label: Text('Usluga')),
      DataColumn(label: Text('Potvrđeno')),
      DataColumn(label: Text('Bilješke')),
      DataColumn(label: Text('Pacijent')),
      DataColumn(label: Text('Uposlenik')),
      DataColumn(label: Text('Uredi')),
      DataColumn(label: Text('Briši')),
    ];

    final List<DataRow> rows = _appointments.map((appointment) {
      final patientName =
          '${appointment.patient?.firstName ?? ''} ${appointment.patient?.lastName ?? ''}';
      final employeeName =
          '${appointment.employee?.firstName ?? ''} ${appointment.employee?.lastName ?? ''}';
      return DataRow(
        cells: [
          DataCell(Text(DateFormat('dd.MM.yyyy  HH:mm')
              .format(appointment.appointmentDateTime ?? DateTime.now()))),
          DataCell(Text(appointment.service?.name ?? '')),
          DataCell(
            appointment.isConfirmed == true
                ? Icon(Icons.check, color: Colors.green)
                : Icon(Icons.close, color: Colors.red),
          ),
          DataCell(Text(appointment.notes ?? '')),
          DataCell(Text(patientName)),
          DataCell(Text(employeeName)),
          DataCell(_buildIconButton(Icons.edit, 'Uredi', () {
            _addOrUpdateAppointment(appointment, isUpdate: true);
          })),
          DataCell(_buildIconButton(Icons.delete, 'Briši', () {
            _showDeleteConfirmationDialog(context, appointment.appointmentId!);
          })),
        ],
      );
    }).toList();

    return PageableListScreen(
      currentPage: 'Termini',
      columns: columns,
      rows: rows,
      isAddButtonHidden: true,
      searchCallback: (value) => _searchAppointments(value),
      filterButtonCallback: () => _showFilterModal(),
      totalCount: _totalCount,
      onPageChanged: (int newPage) => _fetchAppointments(
        page: newPage,
        searchTerm: _currentSearchTerm,
        dateFrom: _currentDateFrom,
        dateTo: _currentDateTo,
        isConfirmed: _currentIsConfirmed,
      ),
      currentPageIndex: _currentPage,
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda brisanja'),
          content: Text('Jeste li sigurni da želite obrisati ovaj termin?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _appointmentProvider.delete(appointmentId);
                _fetchAppointments(
                  page: _currentPage,
                  searchTerm: _currentSearchTerm,
                  dateFrom: _currentDateFrom,
                  dateTo: _currentDateTo,
                  isConfirmed: _currentIsConfirmed,
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
