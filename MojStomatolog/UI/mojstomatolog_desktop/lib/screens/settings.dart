import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/models/order.dart';
import 'package:mojstomatolog_desktop/providers/company_settings_provider.dart';
import 'package:mojstomatolog_desktop/providers/order_provider.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';
import 'package:mojstomatolog_desktop/providers/user_provider.dart';
import 'package:mojstomatolog_desktop/utils/util.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isEditingProfile = false, isEditingCompany = false;
  final _productProvider = ProductProvider();
  final _userProvider = UserProvider();
  final _companySettingsProvider = CompanySettingsProvider();
  final _orderProvider = OrderProvider();
  List<Order> _orders = [];

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _workHoursFromController = TextEditingController();
  final _workHoursToController = TextEditingController();

  final _profileFormKey = GlobalKey<FormState>();
  final _companyFormKey = GlobalKey<FormState>();

  String _initialName = User.firstName ?? '';
  String _initialSurname = User.lastName ?? '';
  String _initialEmail = User.email ?? '';
  String _initialPhoneNumber = User.number ?? '';
  String _initialWorkHoursFrom = '';
  String _initialWorkHoursTo = '';

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    _nameController.text = _initialName;
    _surnameController.text = _initialSurname;
    _emailController.text = _initialEmail;
    _phoneNumberController.text = _initialPhoneNumber;
    _initializeWorkHours();
    _loadOrders();
  }

  Future<void> _initializeWorkHours() async {
    try {
      final companySettings =
          await _companySettingsProvider.getByName('WorkingHours');
      if (companySettings['settingValue'] != null) {
        final workHours = companySettings['settingValue'].split('-');
        if (workHours.length == 2) {
          setState(() {
            _initialWorkHoursFrom = workHours[0];
            _initialWorkHoursTo = workHours[1];
          });
        }
      }
    } catch (e) {
      print("Error initializing work hours: $e");
    }
    _workHoursFromController.text = _initialWorkHoursFrom;
    _workHoursToController.text = _initialWorkHoursTo;
  }

  Future<void> _updateWorkHours() async {
    final newWorkHours =
        '${_workHoursFromController.text}-${_workHoursToController.text}';
    await _companySettingsProvider.addOrUpdate('WorkingHours', newWorkHours);
  }

  bool _isTimeFormatValid(String value) {
    final timePattern = RegExp(r'^\d{2}:\d{2}$');
    return timePattern.hasMatch(value);
  }

  void _resetProfileFields() {
    setState(() {
      _nameController.text = _initialName;
      _surnameController.text = _initialSurname;
      _emailController.text = _initialEmail;
      _phoneNumberController.text = _initialPhoneNumber;
      _profileFormKey.currentState?.reset();
    });
  }

  void _resetCompanyFields() {
    setState(() {
      _workHoursFromController.text = _initialWorkHoursFrom;
      _workHoursToController.text = _initialWorkHoursTo;
      _companyFormKey.currentState?.reset();
    });
  }

  Future<void> _retrainModel() async {
    try {
      await _productProvider.retrainModel();
    } catch (e) {
      print('Error retraining model: $e');
    }
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await _orderProvider.get();
      setState(() => _orders = orders.results);
    } catch (e) {
      print('Error loading orders: $e');
    }
  }

  Widget _buildProfileSettingsForm() {
    return Form(
      key: _profileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(_nameController, 'Ime', isEditing: isEditingProfile),
          _buildTextField(_surnameController, 'Prezime',
              isEditing: isEditingProfile),
          _buildTextField(_emailController, 'Email',
              isEditing: isEditingProfile, isEmail: true),
          _buildTextField(_phoneNumberController, 'Broj telefona',
              isEditing: isEditingProfile, isNumber: true),
          _buildEditingActions(isEditingProfile, _toggleProfileEditing,
              _resetProfileFields, _saveProfile),
        ],
      ),
    );
  }

  Widget _buildCompanySettingsForm() {
    return Form(
      key: _companyFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(_workHoursFromController, 'Radno vrijeme - Od',
              isEditing: isEditingCompany, isTime: true),
          _buildTextField(_workHoursToController, 'Radno vrijeme - Do',
              isEditing: isEditingCompany, isTime: true),
          _buildEditingActions(isEditingCompany, _toggleCompanyEditing,
              _resetCompanyFields, _updateWorkHours),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isEditing = false,
      bool isEmail = false,
      bool isNumber = false,
      bool isTime = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: !isEditing,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : isNumber
                ? TextInputType.number
                : TextInputType.text,
        validator: (value) => _validateField(value,
            isEmail: isEmail, isNumber: isNumber, isTime: isTime),
        onTap: () => !isEditing
            ? FocusScope.of(context).requestFocus(FocusNode())
            : null,
      ),
    );
  }

  String? _validateField(String? value,
      {bool isEmail = false, bool isNumber = false, bool isTime = false}) {
    if (value == null || value.isEmpty) return 'Polje ne smije biti prazno';
    if (isEmail) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) return 'Neispravan email';
    }
    if (isNumber && (!value.contains(RegExp(r'^[0-9]+$')) || value.length < 6))
      return 'Unesite valjan broj';
    if (isTime && !_isTimeFormatValid(value))
      return 'Neispravan format vremena (XX:XX)';
    return null;
  }

  Widget _buildEditingActions(bool isEditing, VoidCallback toggleEdit,
      VoidCallback resetFields, VoidCallback saveChanges) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isEditing)
            ElevatedButton(onPressed: toggleEdit, child: Text('Uredi')),
          if (isEditing) ...[
            ElevatedButton(onPressed: resetFields, child: Text('Odustani')),
            SizedBox(width: 8),
            ElevatedButton(onPressed: saveChanges, child: Text('Spasi')),
          ],
        ],
      ),
    );
  }

  void _toggleProfileEditing() =>
      setState(() => isEditingProfile = !isEditingProfile);
  void _toggleCompanyEditing() =>
      setState(() => isEditingCompany = !isEditingCompany);

  void _saveProfile() {
    if (_profileFormKey.currentState?.validate() ?? false) {
      setState(() => isEditingProfile = false);
      _initialName = _nameController.text;
      _initialSurname = _surnameController.text;
      _initialEmail = _emailController.text;
      _initialPhoneNumber = _phoneNumberController.text;

      var user = {
        "firstName": _nameController.text,
        "lastName": _surnameController.text,
        "email": _emailController.text,
        "number": _phoneNumberController.text,
      };

      User.firstName = _nameController.text;
      User.lastName = _surnameController.text;
      User.email = _emailController.text;
      User.number = _phoneNumberController.text;

      _userProvider.update(User.userId!, user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Postavke',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Postavke profila',
                style: Theme.of(context).textTheme.titleLarge),
            _buildProfileSettingsForm(),
            Divider(height: 32, thickness: 2),
            Text('Postavke kompanije',
                style: Theme.of(context).textTheme.titleLarge),
            _buildCompanySettingsForm(),
            Divider(height: 32, thickness: 2),
            Text('Dodatne opcije',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _retrainModel,
              child: Text('Ponovo istreniraj model preporuke'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showOrdersDialog,
              child: Text('Pregledaj narudžbe'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generatePdfReport,
              child: Text('Napravi izvještaj'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdfReport() async {
    try {
      await _companySettingsProvider.getPdfReport();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izvještaj je uspješno generisan.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Greška pri generisanju izvještaja: $e')));
    }
  }

  void _showOrdersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Narudžbe'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = _orders[index];
                return ListTile(
                  title: Text('Narudžba #${order.id}'),
                  subtitle: Text(
                      'Datum: ${DateFormat('dd.MM.yyyy').format(order.orderDate ?? DateTime.now())}'),
                  onTap: () => _showOrderDetails(order),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalji narudžbe #${order.id}'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: order.orderItems?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final orderItem = order.orderItems![index];
                return ListTile(
                  title: Text(orderItem.product?.name ?? 'Proizvod'),
                  subtitle: Text('Količina: ${orderItem.quantity}'),
                  trailing: Text('Cijena: ${orderItem.price} KM'),
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }
}
