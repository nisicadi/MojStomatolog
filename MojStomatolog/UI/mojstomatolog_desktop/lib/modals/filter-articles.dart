import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleFilterModal extends StatefulWidget {
  final Function(DateTime? dateFrom, DateTime? dateTo, String? searchTerm)
      onFilter;
  final DateTime? initialDateFrom;
  final DateTime? initialDateTo;
  final String? initialSearchTerm;

  const ArticleFilterModal({
    Key? key,
    required this.onFilter,
    this.initialDateFrom,
    this.initialDateTo,
    this.initialSearchTerm,
  }) : super(key: key);

  @override
  _ArticleFilterModalState createState() => _ArticleFilterModalState();
}

class _ArticleFilterModalState extends State<ArticleFilterModal> {
  late TextEditingController _dateFromController;
  late TextEditingController _dateToController;
  late TextEditingController _searchTermController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dateFromController = TextEditingController(
      text: widget.initialDateFrom != null
          ? DateFormat('dd.MM.yyyy').format(widget.initialDateFrom!)
          : '',
    );
    _dateToController = TextEditingController(
      text: widget.initialDateTo != null
          ? DateFormat('dd.MM.yyyy').format(widget.initialDateTo!)
          : '',
    );
    _searchTermController = TextEditingController(
      text: widget.initialSearchTerm ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filtriraj članke'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDateField(_dateFromController, 'Datum objavljivanja od'),
              _buildDateField(_dateToController, 'Datum objavljivanja do'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _dateFromController.clear();
            _dateToController.clear();
          },
          child: Text('Očisti filtere'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              widget.onFilter(
                _dateFromController.text.isNotEmpty
                    ? DateFormat('dd.MM.yyyy').parse(_dateFromController.text)
                    : null,
                _dateToController.text.isNotEmpty
                    ? DateFormat('dd.MM.yyyy').parse(_dateToController.text)
                    : null,
                _searchTermController.text.isNotEmpty
                    ? _searchTermController.text
                    : null,
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
          final dateFrom =
              DateFormat('dd.MM.yyyy').parse(_dateFromController.text);
          final dateTo = DateFormat('dd.MM.yyyy').parse(_dateToController.text);
          if (dateFrom.isAfter(dateTo)) {
            return 'Datum "do" mora biti veći ili jednak datumu "od".';
          }
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: controller.text.isNotEmpty
              ? DateFormat('dd.MM.yyyy').parse(controller.text)
              : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          setState(() {
            controller.text = DateFormat('dd.MM.yyyy').format(pickedDate);
          });
        }
      },
    );
  }
}
