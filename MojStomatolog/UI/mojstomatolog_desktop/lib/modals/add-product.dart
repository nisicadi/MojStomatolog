import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for FilteringTextInputFormatter
import 'package:mojstomatolog_desktop/models/product.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';

class AddProductModal extends StatefulWidget {
  final Function(Product) onProductAdded;
  final Product? initialProduct;

  const AddProductModal({
    Key? key,
    required this.onProductAdded,
    this.initialProduct,
  }) : super(key: key);

  @override
  _AddProductModalState createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  final ProductProvider _productProvider = ProductProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final ValueNotifier<bool> _activeController = ValueNotifier<bool>(false);

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialProduct != null) {
      _isEditing = true;
      _loadInitialData(widget.initialProduct!);
    }
  }

  void _loadInitialData(Product product) {
    _nameController.text = product.name ?? '';
    _descriptionController.text = product.description ?? '';
    _categoryController.text = product.category ?? '';
    _priceController.text = product.price?.toString() ?? '';
    _imageUrlController.text = product.imageUrl ?? '';
    _activeController.value = product.active ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi proizvod' : 'Dodaj novi proizvod'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(_nameController, 'Naziv'),
              _buildTextField(_descriptionController, 'Opis'),
              _buildTextField(_categoryController, 'Kategorija'),
              _buildTextField(_priceController, 'Cijena', numericOnly: true),
              _buildTextField(_imageUrlController, 'URL slike'),
              _buildCheckbox(_activeController, 'Aktivan'),
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
              var updatedProduct = Product();
              updatedProduct.productId = widget.initialProduct?.productId;
              updatedProduct.name = _nameController.text;
              updatedProduct.description = _descriptionController.text;
              updatedProduct.category = _categoryController.text;
              updatedProduct.price = double.tryParse(_priceController.text);
              updatedProduct.imageUrl = _imageUrlController.text;
              updatedProduct.active = _activeController.value;

              try {
                final result = _isEditing
                    ? await _productProvider.update(
                        widget.initialProduct!.productId!, updatedProduct)
                    : await _productProvider.insert(updatedProduct);

                widget.onProductAdded(result!);
                Navigator.of(context).pop();
              } catch (e) {
                print(_isEditing
                    ? 'Greška prilikom ažuriranja proizvoda: $e'
                    : 'Greška prilikom dodavanja proizvoda: $e');
              }
            }
          },
          child: Text(_isEditing ? 'Spremi promjene' : 'Dodaj'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool numericOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: numericOnly
              ? TextInputType.numberWithOptions(decimal: true)
              : null,
          inputFormatters: numericOnly
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ]
              : null,
          decoration: InputDecoration(labelText: labelText),
          validator: (value) {
            if (numericOnly) {
              if (value == null || value.isEmpty) {
                return '$labelText je obavezno polje';
              }
              // Check if the entered value is a valid numeric format with up to 2 decimals
              if (double.tryParse(value) == null) {
                return 'Unesite ispravnu numeričku vrijednost';
              }
            } else {
              if (value == null || value.isEmpty) {
                return '$labelText je obavezno polje';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCheckbox(ValueNotifier<bool> valueNotifier, String labelText) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            Checkbox(
              value: valueNotifier.value,
              onChanged: (value) {
                setState(() {
                  valueNotifier.value = value ?? false;
                });
              },
            ),
            Text(labelText),
          ],
        );
      },
    );
  }
}
