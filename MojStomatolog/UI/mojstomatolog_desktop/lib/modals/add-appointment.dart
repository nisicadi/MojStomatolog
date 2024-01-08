import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    if (widget.initialAppointment != null) {
      _isEditing = true;
      _loadInitialData(widget.initialAppointment!);
    }
  }

  void _loadInitialData(Appointment appointment) {
    _selectedDate = appointment.appointmentDateTime;
    _dateController.text = _selectedDate != null
        ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
        : '';
    _procedureController.text = appointment.procedure ?? '';
    _notesController.text = appointment.notes ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi termin' : 'Dodaj novi termin'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDateField(),
              _buildTextField(_procedureController, 'Procedura'),
              _buildTextField(_notesController, 'Komentar', isOptional: true),
            ],
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
              updatedAppointment.isConfirmed =
                  widget.initialAppointment?.isConfirmed ?? false;

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
          decoration: InputDecoration(labelText: 'Datum termina'),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
                _dateController.text =
                    '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}';
              });
            }
          },
          validator: (value) {
            if (_selectedDate == null) {
              return 'Datum termina je obavezno polje';
            }
            return null;
          },
        ),
      ],
    );
  }
}
