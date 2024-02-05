import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/models/article.dart';
import 'package:mojstomatolog_desktop/providers/article_provider.dart';

class AddArticleModal extends StatefulWidget {
  final Function(Article) onArticleAdded;
  final Article? initialArticle;

  const AddArticleModal({
    Key? key,
    required this.onArticleAdded,
    this.initialArticle,
  }) : super(key: key);

  @override
  _AddArticleModalState createState() => _AddArticleModalState();
}

class _AddArticleModalState extends State<AddArticleModal> {
  final ArticleProvider _articleProvider = ArticleProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _publishDateController = TextEditingController();

  DateTime? _selectedDate;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialArticle != null) {
      _isEditing = true;
      _loadInitialData(widget.initialArticle!);
    } else {
      _selectedDate = DateTime.now();
      _publishDateController.text =
          DateFormat('dd.MM.yyyy').format(_selectedDate!);
    }
  }

  void _loadInitialData(Article article) {
    _titleController.text = article.title ?? '';
    _summaryController.text = article.summary ?? '';
    _contentController.text = article.content ?? '';
    _selectedDate = article.publishDate;
    _publishDateController.text = _selectedDate != null
        ? DateFormat('dd.MM.yyyy').format(_selectedDate!)
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Uredi članak' : 'Dodaj novi članak'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_titleController, 'Naslov'),
                _buildTextField(_summaryController, 'Sažetak'),
                _buildTextField(_contentController, 'Sadržaj'),
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
              var updatedArticle = Article();
              updatedArticle.articleId = widget.initialArticle?.articleId;
              updatedArticle.title = _titleController.text;
              updatedArticle.summary = _summaryController.text;
              updatedArticle.content = _contentController.text;
              updatedArticle.publishDate = _selectedDate;

              try {
                final result = _isEditing
                    ? await _articleProvider.update(
                        widget.initialArticle!.articleId!, updatedArticle)
                    : await _articleProvider.insert(updatedArticle);

                widget.onArticleAdded(result! as Article);
                Navigator.of(context).pop();
              } catch (e) {
                print(_isEditing
                    ? 'Greška prilikom ažuriranja članka: $e'
                    : 'Greška prilikom dodavanja članka: $e');
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
    String labelText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: labelText),
          validator: (value) {
            if (value == null || value.isEmpty) {
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
          controller: _publishDateController,
          decoration: InputDecoration(labelText: 'Datum objave'),
          readOnly: true,
          enabled: false,
          validator: (value) {
            if (_selectedDate == null) {
              return 'Datum objave je obavezno polje';
            }
            return null;
          },
        ),
      ],
    );
  }
}
