import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/models/product_category.dart';
import 'package:mojstomatolog_desktop/providers/product_category_provider.dart';

class AddProductCategoryModal extends StatefulWidget {
  final Function(ProductCategory) onCategoryAdded;
  final ProductCategory? initialCategory;

  const AddProductCategoryModal({
    Key? key,
    required this.onCategoryAdded,
    this.initialCategory,
  }) : super(key: key);

  @override
  _AddProductCategoryModalState createState() =>
      _AddProductCategoryModalState();
}

class _AddProductCategoryModalState extends State<AddProductCategoryModal> {
  final ProductCategoryProvider _categoryProvider = ProductCategoryProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _isEditing = true;
      _loadInitialData(widget.initialCategory!);
    }
  }

  void _loadInitialData(ProductCategory category) {
    _nameController.text = category.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi kategoriju' : 'Dodaj novu kategoriju'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                _buildTextField(_nameController, 'Naziv'),
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
              var updatedCategory = ProductCategory()
                ..name = _nameController.text;

              try {
                final result = _isEditing
                    ? await _categoryProvider.update(
                        widget.initialCategory!.productCategoryId!,
                        updatedCategory)
                    : await _categoryProvider.insert(updatedCategory);

                widget.onCategoryAdded(result!);
                Navigator.of(context).pop();
              } catch (e) {
                print(_isEditing
                    ? 'Greška prilikom ažuriranja kategorije: $e'
                    : 'Greška prilikom dodavanja kategorije: $e');
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
        if (value?.trim().isEmpty ?? true) {
          return '$labelText je obavezno polje';
        }
        return null;
      },
    );
  }
}
