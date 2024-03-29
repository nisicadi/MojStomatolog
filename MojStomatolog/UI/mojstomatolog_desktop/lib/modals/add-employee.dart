import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/models/employee.dart';
import 'package:mojstomatolog_desktop/providers/employee_provider.dart';

class AddEmployeeModal extends StatefulWidget {
  final Function(Employee) onEmployeeAdded;
  final Employee? initialEmployee;

  const AddEmployeeModal({
    Key? key,
    required this.onEmployeeAdded,
    this.initialEmployee,
  }) : super(key: key);

  @override
  _AddEmployeeModalState createState() => _AddEmployeeModalState();
}

class _AddEmployeeModalState extends State<AddEmployeeModal> {
  final EmployeeProvider _employeeProvider = EmployeeProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  DateTime? _selectedDate;
  bool _isEditing = false;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    if (widget.initialEmployee != null) {
      _isEditing = true;
      _loadInitialData(widget.initialEmployee!);
    }
  }

  void _loadInitialData(Employee employee) {
    _firstNameController.text = employee.firstName ?? '';
    _lastNameController.text = employee.lastName ?? '';
    _emailController.text = employee.email ?? '';
    _numberController.text = employee.number ?? '';
    _specializationController.text = employee.specialization ?? '';
    _startDateController.text = employee.startDate != null
        ? DateFormat('dd.MM.yyyy').format(employee.startDate!)
        : '';
    _selectedDate = employee.startDate;

    if (employee.gender == 'M' || employee.gender == 'F') {
      _selectedGender = employee.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi zaposlenika' : 'Dodaj novog zaposlenika'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_firstNameController, 'Ime'),
                _buildTextField(_lastNameController, 'Prezime'),
                _buildGenderDropdown(),
                _buildTextField(_emailController, 'Email'),
                _buildTextField(_numberController, 'Broj telefona',
                    isNumber: true),
                _buildTextField(_specializationController, 'Specijalizacija'),
                _buildDateField(),
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
              var updatedEmployee = Employee();
              updatedEmployee.employeeId = widget.initialEmployee?.employeeId;
              updatedEmployee.firstName = _firstNameController.text;
              updatedEmployee.lastName = _lastNameController.text;
              updatedEmployee.gender = _selectedGender;
              updatedEmployee.email = _emailController.text;
              updatedEmployee.number = _numberController.text;
              updatedEmployee.specialization = _specializationController.text;
              updatedEmployee.startDate = _selectedDate;

              try {
                final result = _isEditing
                    ? await _employeeProvider.update(
                        widget.initialEmployee!.employeeId!, updatedEmployee)
                    : await _employeeProvider.insert(updatedEmployee);

                widget.onEmployeeAdded(result!);
                Navigator.of(context).pop();
              } catch (e) {
                print(_isEditing
                    ? 'Error updating employee: $e'
                    : 'Error adding employee: $e');
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
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          decoration: InputDecoration(labelText: labelText),
          validator: (value) {
            if (labelText == 'Spol') {
              if (value != 'M' && value != 'F') {
                return 'Spol mora biti "M" ili "F"';
              }
            } else {
              if (!isOptional && (value?.trim().isEmpty ?? true)) {
                return '$labelText je obavezno polje';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: _selectedGender,
          items: [
            DropdownMenuItem<String>(
              value: 'M',
              child: Text('Muški'),
            ),
            DropdownMenuItem<String>(
              value: 'F',
              child: Text('Ženski'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
          decoration: InputDecoration(labelText: 'Spol'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Spol je obavezno polje';
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
          controller: _startDateController,
          decoration: InputDecoration(labelText: 'Datum početka rada'),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
                _startDateController.text =
                    DateFormat('dd.MM.yyyy').format(_selectedDate!);
              });
            }
          },
          validator: (value) {
            if (_selectedDate == null) {
              return 'Datum početka rada je obavezno polje';
            } else if (_selectedDate!.isAfter(DateTime.now())) {
              return 'Datum početka rada ne može biti u budućnosti';
            }
            return null;
          },
        ),
      ],
    );
  }
}
