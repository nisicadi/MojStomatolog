import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/models/service.dart';
import 'package:mojstomatolog_desktop/providers/service_provider.dart';

class AddServiceModal extends StatefulWidget {
  final Function(Service) onServiceAdded;
  final Service? initialService;

  const AddServiceModal({
    Key? key,
    required this.onServiceAdded,
    this.initialService,
  }) : super(key: key);

  @override
  _AddServiceModalState createState() => _AddServiceModalState();
}

class _AddServiceModalState extends State<AddServiceModal> {
  final ServiceProvider _categoryService = ServiceProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialService != null) {
      _isEditing = true;
      _loadInitialData(widget.initialService!);
    }
  }

  void _loadInitialData(Service service) {
    _nameController.text = service.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi uslugu' : 'Dodaj novu uslugu'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                _buildTextField(_nameController, 'Naziv usluge'),
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
              var updatedService = Service()..name = _nameController.text;

              try {
                final result = _isEditing
                    ? await _categoryService.update(
                        widget.initialService!.id!, updatedService)
                    : await _categoryService.insert(updatedService);

                widget.onServiceAdded(result!);
                Navigator.of(context).pop();
              } catch (e) {
                print(_isEditing
                    ? 'Greška prilikom ažuriranja usluge: $e'
                    : 'Greška prilikom dodavanja usluge: $e');
              }
            }
          },
          child: Text(_isEditing ? 'Spremi promjene' : 'Dodaj'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText je obavezno polje';
        }
        return null;
      },
    );
  }
}
