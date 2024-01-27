import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_mobile/models/appointment.dart';
import 'package:mojstomatolog_mobile/models/search/appointment_search.dart';
import 'package:mojstomatolog_mobile/providers/appointment_provider.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';

class MyAppointmentsPage extends StatefulWidget {
  @override
  _MyAppointmentsPageState createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadAppointments({bool refresh = false}) async {
    if (_isLoading && !refresh) return;
    setState(() => _isLoading = true);

    if (refresh) {
      _currentPage = 1;
      _appointments.clear();
    }

    try {
      var provider = AppointmentProvider();
      var searchObject = AppointmentSearchObject()
        ..page = _currentPage
        ..pageSize = _pageSize
        ..patientId = User.userId;

      var searchResult = await provider.get(filter: searchObject.toJson());
      setState(() {
        _appointments.addAll(searchResult.results);
        if (!refresh) {
          _currentPage++;
        }
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadAppointments();
    }
  }

  Future<void> _refreshList() async {
    await _loadAppointments(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moji termini'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _appointments.length,
          itemBuilder: (BuildContext context, int index) {
            Appointment appointment = _appointments[index];
            return Card(
              child: ListTile(
                title: Text(
                    'Termin: ${DateFormat('dd.MM.yyyy HH:mm').format(appointment.appointmentDateTime ?? DateTime.now())}'),
                subtitle: Text('Procedura: ${appointment.procedure}'),
                // Add more details as needed
              ),
            );
          },
        ),
      ),
      floatingActionButton: _isLoading ? CircularProgressIndicator() : null,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
