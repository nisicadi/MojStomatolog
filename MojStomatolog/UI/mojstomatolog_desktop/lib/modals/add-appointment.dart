import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/models/appointment.dart';
import 'package:mojstomatolog_desktop/models/employee.dart';
import 'package:mojstomatolog_desktop/models/service.dart';
import 'package:mojstomatolog_desktop/providers/appointment_provider.dart';
import 'package:mojstomatolog_desktop/providers/employee_provider.dart';
import 'package:mojstomatolog_desktop/providers/service_provider.dart';

class AddAppointmentModal extends StatefulWidget {
  final Function(Appointment) onAppointmentAdded;
  final Appointment? initialAppointment;

  const AddAppointmentModal({
    Key? key,
    required this.onAppointmentAdded,
    this.initialAppointment,
  }) : super(key: key);

  @override
  _AddAppointmentModalState createState() => _AddAppointmentModalState();
}

class _AddAppointmentModalState extends State<AddAppointmentModal> {
  final AppointmentProvider _appointmentProvider = AppointmentProvider();
  final EmployeeProvider _employeeProvider = EmployeeProvider();
  final ServiceProvider _serviceProvider = ServiceProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  bool _isEditing = false;
  bool _isConfirmed = false;
  Employee? _selectedEmployee;
  Service? _selectedService;
  List<Employee> _employees = [];
  List<Service> _services = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialAppointment != null) {
      _isEditing = true;
      _loadInitialData(widget.initialAppointment!);
      _isConfirmed = widget.initialAppointment!.isConfirmed ?? false;
    }

    _fetchData();
  }

  void _fetchData() async {
    try {
      var employeesResult = await _employeeProvider.get();
      _employees.clear();
      _employees.addAll(employeesResult.results);

      var servicesResult = await _serviceProvider.get();
      _services.clear();
      _services.addAll(servicesResult.results);

      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _loadInitialData(Appointment appointment) {
    _selectedDate = appointment.appointmentDateTime;
    _dateController.text =
        DateFormat('dd.MM.yyyy  HH:mm').format(_selectedDate!);
    _notesController.text = appointment.notes ?? '';
    _selectedEmployee = appointment.employee;
    _selectedService = appointment.service;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi termin' : 'Dodaj novi termin'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildDateField(),
                _buildDropdowns(),
                _buildTextField(_notesController, 'Komentar', isOptional: true),
                CheckboxListTile(
                  title: Text('Potvrđeno'),
                  value: _isConfirmed,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isConfirmed = newValue ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Odustani'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              var updatedAppointment = Appointment();
              updatedAppointment.appointmentId =
                  widget.initialAppointment?.appointmentId;
              updatedAppointment.appointmentDateTime = _selectedDate;
              updatedAppointment.notes = _notesController.text;
              updatedAppointment.employeeId = _selectedEmployee?.employeeId;
              updatedAppointment.serviceId = _selectedService?.id;
              updatedAppointment.isConfirmed = _isConfirmed;
              updatedAppointment.patientId =
                  widget.initialAppointment?.patientId!;

              try {
                final result = _isEditing
                    ? await _appointmentProvider.update(
                        widget.initialAppointment!.appointmentId!,
                        updatedAppointment)
                    : await _appointmentProvider.insert(updatedAppointment);

                widget.onAppointmentAdded(result!);
                Navigator.of(context).pop();
              } catch (e) {
                print(_isEditing
                    ? 'Error updating appointment: $e'
                    : 'Error adding appointment: $e');
              }
            }
          },
          child: Text(_isEditing ? 'Spremi promjene' : 'Dodaj'),
        ),
      ],
    );
  }

  Widget _buildDropdowns() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButtonFormField<Service>(
          value: _selectedService,
          items: _services.map((service) {
            return DropdownMenuItem<Service>(
              value: service,
              child: Text(service.name ?? ''),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedService = value;
            });
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
          value: _selectedEmployee,
          items: _employees.map((employee) {
            return DropdownMenuItem<Employee>(
              value: employee,
              child: Text(
                  '${employee.firstName ?? ''} ${employee.lastName ?? ''}'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedEmployee = value;
            });
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
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText, {
    bool isOptional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: labelText),
          validator: (value) {
            if (!isOptional && (value?.trim().isEmpty ?? true)) {
              return '$labelText je obavezno polje';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _dateController,
          decoration: InputDecoration(labelText: 'Datum i vrijeme termina'),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
              );

              if (pickedTime != null) {
                setState(() {
                  _selectedDate = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  _dateController.text =
                      DateFormat('dd.MM.yyyy HH:mm').format(_selectedDate!);
                });
              }
            }
          },
          validator: (value) {
            if (_selectedDate == null) {
              return 'Datum i vrijeme termina je obavezno polje';
            }
            return null;
          },
        ),
      ],
    );
  }
}
