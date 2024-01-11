import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentFilterModal extends StatefulWidget {
  final Function(DateTime? dateFrom, DateTime? dateTo, bool? isConfirmed)
      onFilter;
  final DateTime? initialDateFrom;
  final DateTime? initialDateTo;
  final bool? initialIsConfirmed;

  const AppointmentFilterModal({
    Key? key,
    required this.onFilter,
    this.initialDateFrom,
    this.initialDateTo,
    this.initialIsConfirmed,
  }) : super(key: key);

  @override
  _AppointmentFilterModalState createState() => _AppointmentFilterModalState();
}

class _AppointmentFilterModalState extends State<AppointmentFilterModal> {
  late TextEditingController _dateFromController;
  late TextEditingController _dateToController;
  late bool? _isConfirmed;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dateFromController = TextEditingController(
      text: widget.initialDateFrom != null
          ? DateFormat('dd.MM.yyyy HH:mm').format(widget.initialDateFrom!)
          : '',
    );
    _dateToController = TextEditingController(
      text: widget.initialDateTo != null
          ? DateFormat('dd.MM.yyyy HH:mm').format(widget.initialDateTo!)
          : '',
    );
    _isConfirmed = widget.initialIsConfirmed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter termina'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDateField(
                  _dateFromController, 'Datum i vrijeme termina - od'),
              _buildDateField(
                  _dateToController, 'Datum i vrijeme termina - do'),
              _buildConfirmedDropdown(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _dateFromController.clear();
            _dateToController.clear();
            setState(() {
              _isConfirmed = null;
            });
          },
          child: Text('Ukloni filtere'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              widget.onFilter(
                _dateFromController.text.isNotEmpty
                    ? DateFormat('dd.MM.yyyy HH:mm')
                        .parse(_dateFromController.text)
                    : null,
                _dateToController.text.isNotEmpty
                    ? DateFormat('dd.MM.yyyy HH:mm')
                        .parse(_dateToController.text)
                    : null,
                _isConfirmed,
              );
            }
          },
          child: Text('Pretraži'),
        ),
      ],
    );
  }

  Widget _buildDateField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      readOnly: true,
      validator: (value) {
        if (_dateFromController.text.isNotEmpty &&
            _dateToController.text.isNotEmpty) {
          final dateTimeFrom =
              DateFormat('dd.MM.yyyy HH:mm').parse(_dateFromController.text);
          final dateTimeTo =
              DateFormat('dd.MM.yyyy HH:mm').parse(_dateToController.text);
          if (dateTimeFrom.isAfter(dateTimeTo)) {
            return 'Datum i vrijeme "Do" moraju biti veći ili jednaki datumu i vremenu "Od".';
          }
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: controller.text.isNotEmpty
              ? DateFormat('dd.MM.yyyy HH:mm').parse(controller.text)
              : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(controller.text.isNotEmpty
                ? DateFormat('dd.MM.yyyy HH:mm').parse(controller.text)
                : DateTime.now()),
          );

          if (pickedTime != null) {
            DateTime finalDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            setState(() {
              controller.text =
                  DateFormat('dd.MM.yyyy HH:mm').format(finalDateTime);
            });
          }
        }
      },
    );
  }

  Widget _buildConfirmedDropdown() {
    return DropdownButtonFormField<bool>(
      value: _isConfirmed,
      onChanged: (value) {
        setState(() {
          _isConfirmed = value;
        });
      },
      items: [
        DropdownMenuItem<bool>(
          value: null,
          child: Text('Sve'),
        ),
        DropdownMenuItem<bool>(
          value: true,
          child: Text('Potvrđen'),
        ),
        DropdownMenuItem<bool>(
          value: false,
          child: Text('Nepotvrđen'),
        ),
      ],
      decoration: InputDecoration(labelText: 'Status'),
    );
  }
}
