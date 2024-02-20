import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_mobile/models/search/appointment_search.dart';
import 'package:mojstomatolog_mobile/providers/company_settings_provider.dart';
import 'package:mojstomatolog_mobile/models/appointment.dart';
import 'package:mojstomatolog_mobile/providers/appointment_provider.dart';
import 'package:mojstomatolog_mobile/providers/service_provider.dart';
import 'package:mojstomatolog_mobile/providers/employee_provider.dart';
import 'package:mojstomatolog_mobile/models/service.dart';
import 'package:mojstomatolog_mobile/models/employee.dart';
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
  final ServiceProvider _serviceProvider = ServiceProvider();
  final EmployeeProvider _employeeProvider = EmployeeProvider();

  List<Appointment> reservedAppointments = [];
  List<Service> services = [];
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkingHours();
    _fetchReservedAppointments(selectedDate);
    _fetchServices();
    _fetchEmployees();
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

  Future<void> _fetchServices() async {
    try {
      final services = await _serviceProvider.get();
      setState(() {
        this.services = services.results;
      });
    } catch (e) {
      print('Error fetching services: $e');
    }
  }

  Future<void> _fetchEmployees() async {
    try {
      final employees = await _employeeProvider.get();
      setState(() {
        this.employees = employees.results;
      });
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  void _showReservationModal(
      BuildContext context, String appointmentTime) async {
    bool userHasReservation = reservedAppointments.any((appointment) =>
        appointment.appointmentDateTime?.year == selectedDate.year &&
        appointment.appointmentDateTime?.month == selectedDate.month &&
        appointment.appointmentDateTime?.day == selectedDate.day &&
        appointment.patientId == User.userId);

    if (userHasReservation) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Već ste rezervisali termin za ovaj dan'),
            content: Text('Samo jedna rezervacija dnevno je dozvoljena.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      _ReservationDialog.show(
        context: context,
        services: services,
        employees: employees,
        onReservation: (serviceId, employeeId, notes) {
          _handleCreateAppointment(
              appointmentTime, serviceId, employeeId, notes);
        },
      );
    }
  }

  void _handleCreateAppointment(String appointmentTime, int serviceId,
      int employeeId, String notes) async {
    final newAppointment = Appointment();
    newAppointment.appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      int.parse(appointmentTime.split(':')[0]),
      int.parse(appointmentTime.split(':')[1]),
    );
    newAppointment.serviceId = serviceId;
    newAppointment.employeeId = employeeId;
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

class _ReservationDialog {
  static void show({
    required BuildContext context,
    required List<Service> services,
    required List<Employee> employees,
    required Function(int, int, String) onReservation,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ReservationDialogWidget(
          services: services,
          employees: employees,
          onReservation: onReservation,
        );
      },
    );
  }
}

class _ReservationDialogWidget extends StatefulWidget {
  final List<Service> services;
  final List<Employee> employees;
  final Function(int, int, String) onReservation;

  const _ReservationDialogWidget({
    Key? key,
    required this.services,
    required this.employees,
    required this.onReservation,
  }) : super(key: key);

  @override
  _ReservationDialogWidgetState createState() =>
      _ReservationDialogWidgetState();
}

class _ReservationDialogWidgetState extends State<_ReservationDialogWidget> {
  late Service selectedService;
  late Employee selectedEmployee; // New: Track selected employee
  late String notes;

  @override
  void initState() {
    super.initState();
    selectedService =
        widget.services.isNotEmpty ? widget.services[0] : Service();
    selectedEmployee = widget.employees.isNotEmpty
        ? widget.employees[0]
        : Employee(); // New: Initialize with the first employee
    notes = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rezervacija termina'),
      content: _ReservationDialogContent(
        services: widget.services,
        employees: widget.employees,
        onServiceChange: (value) {
          setState(() {
            selectedService = value;
          });
        },
        onEmployeeChange: (value) {
          setState(() {
            selectedEmployee = value;
          });
        },
        onNotesChange: (value) {
          setState(() {
            notes = value;
          });
        },
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
            widget.onReservation(
                selectedService.id!, selectedEmployee.employeeId!, notes);
            Navigator.of(context).pop();
          },
          child: Text('Rezervisi'),
        ),
      ],
    );
  }
}

class _ReservationDialogContent extends StatefulWidget {
  final List<Service> services;
  final List<Employee> employees;
  final Function(Service) onServiceChange;
  final Function(Employee) onEmployeeChange;
  final Function(String) onNotesChange;

  const _ReservationDialogContent({
    Key? key,
    required this.services,
    required this.employees,
    required this.onServiceChange,
    required this.onEmployeeChange,
    required this.onNotesChange,
  }) : super(key: key);

  @override
  _ReservationDialogContentState createState() =>
      _ReservationDialogContentState();
}

class _ReservationDialogContentState extends State<_ReservationDialogContent> {
  late Service selectedService;
  late Employee selectedEmployee;
  late String notes;

  @override
  void initState() {
    super.initState();
    selectedService =
        widget.services.isNotEmpty ? widget.services[0] : Service();
    selectedEmployee =
        widget.employees.isNotEmpty ? widget.employees[0] : Employee();
    notes = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButtonFormField<Service>(
          value: selectedService,
          items: widget.services.map((service) {
            return DropdownMenuItem<Service>(
              value: service,
              child: Text(service.name!),
            );
          }).toList(),
          onChanged: (value) {
            widget.onServiceChange(value!);
          },
          decoration: InputDecoration(
            labelText: 'Usluga',
          ),
          validator: (value) {
            if (value == null) {
              return 'Izaberite uslugu';
            }
            return null;
          },
        ),
        DropdownButtonFormField<Employee>(
          value: selectedEmployee,
          items: widget.employees.map((employee) {
            return DropdownMenuItem<Employee>(
              value: employee,
              child: Text('${employee.firstName} ${employee.lastName}'),
            );
          }).toList(),
          onChanged: (value) {
            widget.onEmployeeChange(value!);
          },
          decoration: InputDecoration(
            labelText: 'Doktor',
          ),
          validator: (value) {
            if (value == null) {
              return 'Izaberite doktora';
            }
            return null;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Bilješke',
          ),
          onChanged: (value) {
            widget.onNotesChange(value);
          },
        ),
      ],
    );
  }
}
