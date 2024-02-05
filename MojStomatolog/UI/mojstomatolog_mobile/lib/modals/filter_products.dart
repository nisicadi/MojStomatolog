import 'package:flutter/material.dart';

class ProductFilterModal extends StatefulWidget {
  final Function(double? priceFrom, double? priceTo) onFilter;
  final double? initialPriceFrom;
  final double? initialPriceTo;

  const ProductFilterModal({
    Key? key,
    required this.onFilter,
    this.initialPriceFrom,
    this.initialPriceTo,
  }) : super(key: key);

  @override
  _ProductFilterModalState createState() => _ProductFilterModalState();
}

class _ProductFilterModalState extends State<ProductFilterModal> {
  late TextEditingController _priceFromController;
  late TextEditingController _priceToController;
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
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _priceFromController.clear();
            _priceToController.clear();
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
              widget.onFilter(priceFrom, priceTo);
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
}
