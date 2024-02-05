import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojstomatolog_desktop/models/product.dart';
import 'package:mojstomatolog_desktop/models/product_category.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';
import 'package:mojstomatolog_desktop/providers/product_category_provider.dart';

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
  final ProductCategoryProvider _productCategoryProvider =
      ProductCategoryProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final ValueNotifier<bool> _activeController = ValueNotifier<bool>(false);
  List<ProductCategory> _categories = [];
  int? _selectedCategoryId;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    if (widget.initialProduct != null) {
      _isEditing = true;
      _loadInitialData(widget.initialProduct!);
    }
  }

  void _fetchCategories() async {
    final categories = await _productCategoryProvider.get();
    setState(() {
      _categories = categories.results;
    });
    if (_isEditing && widget.initialProduct!.productCategoryId != null) {
      _selectedCategoryId = widget.initialProduct!.productCategoryId;
    }
  }

  void _loadInitialData(Product product) {
    _nameController.text = product.name ?? '';
    _descriptionController.text = product.description ?? '';
    _priceController.text = product.price?.toString() ?? '';
    _imageUrlController.text = product.imageUrl ?? '';
    _activeController.value = product.active ?? false;
    _selectedCategoryId = product.productCategoryId;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi proizvod' : 'Dodaj novi proizvod'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                _buildTextField(_nameController, 'Naziv'),
                _buildTextField(_descriptionController, 'Opis'),
                _buildDropdown(),
                _buildTextField(_priceController, 'Cijena', numericOnly: true),
                _buildTextField(_imageUrlController, 'URL slike'),
                _buildCheckbox(_activeController, 'Aktivan'),
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
              var updatedProduct = Product()
                ..productId = widget.initialProduct?.productId
                ..name = _nameController.text
                ..description = _descriptionController.text
                ..productCategoryId = _selectedCategoryId
                ..price = double.tryParse(_priceController.text)
                ..imageUrl = _imageUrlController.text
                ..active = _activeController.value;

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

  Widget _buildDropdown() {
    return DropdownButtonFormField<int>(
      value: _selectedCategoryId,
      decoration: InputDecoration(labelText: 'Kategorija'),
      onChanged: (int? newValue) {
        setState(() {
          _selectedCategoryId = newValue;
        });
      },
      items: _categories.map<DropdownMenuItem<int>>((ProductCategory category) {
        return DropdownMenuItem<int>(
          value: category.productCategoryId,
          child: Text(category.name ?? ''),
        );
      }).toList(),
      validator: (value) =>
          value == null ? 'Kategorija je obavezno polje' : null,
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool numericOnly = false}) {
    return TextFormField(
      controller: controller,
      keyboardType:
          numericOnly ? TextInputType.numberWithOptions(decimal: true) : null,
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
    );
  }

  Widget _buildCheckbox(ValueNotifier<bool> valueNotifier, String labelText) {
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
  }
}
