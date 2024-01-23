import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/models/appointment.dart';
import 'package:mojstomatolog_desktop/providers/appointment_provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _procedureController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  bool _isEditing = false;
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialAppointment != null) {
      _isEditing = true;
      _loadInitialData(widget.initialAppointment!);
      _isConfirmed = widget.initialAppointment!.isConfirmed ?? false;
    }
  }

  void _loadInitialData(Appointment appointment) {
    _selectedDate = appointment.appointmentDateTime;
    if (_selectedDate != null) {
      _dateController.text =
          DateFormat('dd.MM.yyyy  HH:mm').format(_selectedDate!);
    } else {
      _dateController.text = '';
    }
    _procedureController.text = appointment.procedure ?? '';
    _notesController.text = appointment.notes ?? '';
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
                _buildTextField(_procedureController, 'Procedura'),
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
              updatedAppointment.procedure = _procedureController.text;
              updatedAppointment.notes = _notesController.text;
              updatedAppointment.patientId =
                  widget.initialAppointment?.patientId;
              updatedAppointment.isConfirmed = _isConfirmed;

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
            if (!isOptional && (value == null || value.isEmpty)) {
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
