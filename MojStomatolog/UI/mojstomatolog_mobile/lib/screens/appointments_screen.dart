import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_mobile/models/search/appointment_search.dart';
import 'package:mojstomatolog_mobile/providers/company_settings_provider.dart';
import 'package:mojstomatolog_mobile/models/appointment.dart';
import 'package:mojstomatolog_mobile/providers/appointment_provider.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  DateTime selectedDate = DateTime.now();
  List<String> appointments = [];
  final CompanySettingsProvider _companySettingsProvider =
      CompanySettingsProvider();
  final AppointmentProvider _appointmentProvider = AppointmentProvider();

  List<Appointment> reservedAppointments = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkingHours();
    _fetchReservedAppointments(selectedDate);
  }

  Future<void> _fetchWorkingHours() async {
    try {
      final companySettings =
          await _companySettingsProvider.getByName('WorkingHours');

      if (companySettings.containsKey('settingValue')) {
        final workingHours = companySettings['settingValue'] as String;
        appointments = _generateAppointments(workingHours);
      }
    } catch (e) {
      print('Error fetching working hours: $e');
    }
  }

  List<String> _generateAppointments(String workingHours) {
    final appointments = <String>[];
    final parts = workingHours.split('-');
    if (parts.length == 2) {
      final startTime = parts[0];
      final endTime = parts[1];
      final formatter = DateFormat('HH:mm');
      final start = formatter.parse(startTime);
      final end = formatter.parse(endTime);

      final increment = Duration(hours: 1);
      var currentTime = start;
      while (currentTime.isBefore(end)) {
        appointments.add(formatter.format(currentTime));
        currentTime = currentTime.add(increment);
      }
    }
    return appointments;
  }

  Future<void> _fetchReservedAppointments(DateTime date) async {
    try {
      var searchObject = AppointmentSearchObject()
        ..dateTimeFrom = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          0,
          0,
        )
        ..dateTimeTo = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          23,
          59,
        );

      final reservedAppointments =
          await _appointmentProvider.get(filter: searchObject.toJson());

      setState(() {
        this.reservedAppointments = reservedAppointments.results;
      });
    } catch (e) {
      print('Error fetching reserved appointments: $e');
    }
  }

  void _showReservationModal(BuildContext context, String appointmentTime) {
    String procedure = '';
    String notes = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rezervacija termina'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Procedura',
                ),
                onChanged: (value) {
                  procedure = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Bilješke',
                ),
                onChanged: (value) {
                  notes = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Odustani'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleCreateAppointment(appointmentTime, procedure, notes);
                Navigator.of(context).pop();
              },
              child: Text('Rezervisi'),
            ),
          ],
        );
      },
    );
  }

  void _handleCreateAppointment(
      String appointmentTime, String procedure, String notes) async {
    final newAppointment = Appointment();
    newAppointment.appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(appointmentTime.split(':')[0]),
      int.parse(appointmentTime.split(':')[1]),
    );
    newAppointment.procedure = procedure;
    newAppointment.notes = notes;
    newAppointment.isConfirmed = false;
    newAppointment.patientId = User.userId;

    try {
      final createdAppointment =
          await _appointmentProvider.insert(newAppointment.toJson());

      if (createdAppointment != null) {
        print('Appointment created: ${createdAppointment.appointmentId}');
        await _fetchReservedAppointments(selectedDate);
      } else {
        print('Failed to create appointment.');
      }
    } catch (e) {
      print('Error creating appointment: $e');
    }
  }

  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 1,
      child: Column(
        children: [
          _buildDatePicker(),
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointmentTime = appointments[index];
                final isReserved = reservedAppointments.any((appointment) =>
                    appointment.appointmentDateTime?.hour ==
                        int.parse(appointmentTime.split(':')[0]) &&
                    appointment.appointmentDateTime?.minute ==
                        int.parse(appointmentTime.split(':')[1]));

                return _buildAppointmentItem(
                    context, appointmentTime, isReserved);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('dd.MM.yyyy').format(selectedDate),
            style: TextStyle(fontSize: 18),
          ),
          ElevatedButton(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );

              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
                await _fetchReservedAppointments(selectedDate);
              }
            },
            child: Text("Promijeni datum"),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(
      BuildContext context, String appointmentTime, bool isReserved) {
    final currentDateTime = DateTime.now();
    final appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(appointmentTime.split(':')[0]),
      int.parse(appointmentTime.split(':')[1]),
    );

    final isPastTime = appointmentDateTime.isBefore(currentDateTime);

    final isUserAppointment = reservedAppointments.any((appointment) =>
        appointment.appointmentDateTime == appointmentDateTime &&
        appointment.patientId == User.userId);

    final isCancelable = currentDateTime.isBefore(appointmentDateTime) &&
        isReserved &&
        isUserAppointment;

    return Column(
      children: [
        Divider(height: 1, thickness: 1),
        ListTile(
          leading: Icon(Icons.access_time),
          title: Text(appointmentTime),
          trailing: isReserved
              ? isUserAppointment
                  ? ElevatedButton(
                      onPressed: isCancelable
                          ? () {
                              _showCancellationConfirmationDialog(
                                  context, appointmentDateTime);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text("Otkaži"),
                    )
                  : ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: Text("Rezervisano"),
                    )
              : !isPastTime
                  ? ElevatedButton(
                      onPressed: () =>
                          _showReservationModal(context, appointmentTime),
                      child: Text("Rezervisi"),
                    )
                  : Text("Vrijeme prošlo",
                      style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  void _showCancellationConfirmationDialog(
      BuildContext context, DateTime appointmentDateTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda otkazivanja'),
          content: Text('Jeste li sigurni da želite otkazati termin?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ne'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _handleCancelAppointment(appointmentDateTime);
                Navigator.of(context).pop();
              },
              child: Text('Da'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleCancelAppointment(DateTime appointmentDateTime) async {
    final appointmentToCancel = reservedAppointments.firstWhere((appointment) =>
        appointment.appointmentDateTime == appointmentDateTime);

    final appointmentId = appointmentToCancel.appointmentId;

    try {
      await _appointmentProvider.delete(appointmentId!);
      await _fetchReservedAppointments(selectedDate);
    } catch (e) {
      print('Error canceling appointment: $e');
    }
  }
}
