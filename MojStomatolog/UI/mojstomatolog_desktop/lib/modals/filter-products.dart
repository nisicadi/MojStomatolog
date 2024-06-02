import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductFilterModal extends StatefulWidget {
  final Function(double? priceFrom, double? priceTo, bool? isActive) onFilter;
  final double? initialPriceFrom;
  final double? initialPriceTo;
  final bool? initialIsActive;

  const ProductFilterModal({
    Key? key,
    required this.onFilter,
    this.initialPriceFrom,
    this.initialPriceTo,
    this.initialIsActive,
  }) : super(key: key);

  @override
  _ProductFilterModalState createState() => _ProductFilterModalState();
}

class _ProductFilterModalState extends State<ProductFilterModal> {
  late TextEditingController _priceFromController;
  late TextEditingController _priceToController;
  bool? _isActive;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _priceFromError;
  String? _priceToError;

  @override
  void initState() {
    super.initState();
    _priceFromController = TextEditingController(
        text: widget.initialPriceFrom != null
            ? widget.initialPriceFrom.toString()
            : '');
    _priceToController = TextEditingController(
        text: widget.initialPriceTo != null
            ? widget.initialPriceTo.toString()
            : '');
    _isActive = widget.initialIsActive;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter proizvoda'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildPriceField(
                  _priceFromController, 'Cijena od', _priceFromError),
              _buildPriceField(_priceToController, 'Cijena do', _priceToError),
              _buildActiveDropdown(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _priceFromController.clear();
            _priceToController.clear();
            setState(() {
              _isActive = null;
            });
          },
          child: Text('Ukloni filtere'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              double? priceFrom;
              double? priceTo;

              if (_priceFromController.text.isNotEmpty) {
                priceFrom = double.tryParse(_priceFromController.text);
              }

              if (_priceToController.text.isNotEmpty) {
                priceTo = double.tryParse(_priceToController.text);
              }

              if (priceFrom != null && priceTo != null && priceTo < priceFrom) {
                setState(() {
                  _priceFromError =
                      'Cijena do mora biti veća ili jednaka cijeni od.';
                  _priceToError =
                      'Cijena do mora biti veća ili jednaka cijeni od.';
                });
                return;
              }

              setState(() {
                _priceFromError = null;
                _priceToError = null;
              });

              Navigator.of(context).pop();
              widget.onFilter(priceFrom, priceTo, _isActive);
            }
          },
          child: Text('Filtriraj'),
        ),
      ],
    );
  }

  Widget _buildPriceField(
      TextEditingController controller, String labelText, String? errorText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, errorText: errorText),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          final double? price = double.tryParse(value);
          if (price == null) {
            return 'Nevažeći unos';
          }
        }
        return null;
      },
    );
  }

  Widget _buildActiveDropdown() {
    return DropdownButtonFormField<bool>(
      value: _isActive,
      onChanged: (value) {
        setState(() {
          _isActive = value;
        });
      },
      items: [
        DropdownMenuItem<bool>(
          value: null,
          child: Text('Sve'),
        ),
        DropdownMenuItem<bool>(
          value: true,
          child: Text('Aktivan'),
        ),
        DropdownMenuItem<bool>(
          value: false,
          child: Text('Neaktivan'),
        ),
      ],
      decoration: InputDecoration(labelText: 'Status'),
    );
  }
}
