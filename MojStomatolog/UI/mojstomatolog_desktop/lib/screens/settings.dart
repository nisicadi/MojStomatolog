import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mojstomatolog_desktop/enums/order_status.dart';
import 'package:mojstomatolog_desktop/models/order.dart';
import 'package:mojstomatolog_desktop/providers/company_settings_provider.dart';
import 'package:mojstomatolog_desktop/providers/order_provider.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';
import 'package:mojstomatolog_desktop/providers/user_provider.dart';
import 'package:mojstomatolog_desktop/utils/util.dart';
import 'package:mojstomatolog_desktop/widgets/company_settings_form.dart';
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
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _profileFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  String _initialName = User.firstName ?? '';
  String _initialSurname = User.lastName ?? '';
  String _initialEmail = User.email ?? '';
  String _initialPhoneNumber = User.number ?? '';

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
  }

  void _resetProfileFields() {
    setState(() {
      _nameController.text = _initialName;
      _surnameController.text = _initialSurname;
      _emailController.text = _initialEmail;
      _phoneNumberController.text = _initialPhoneNumber;
      _profileFormKey.currentState?.reset();
      _toggleProfileEditing();
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

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isEditing = false, bool isEmail = false, bool isNumber = false}) {
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
        validator: (value) =>
            _validateField(value, isEmail: isEmail, isNumber: isNumber),
        onTap: () => !isEditing
            ? FocusScope.of(context).requestFocus(FocusNode())
            : null,
        inputFormatters:
            isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      ),
    );
  }

  String? _validateField(String? value,
      {bool isEmail = false, bool isNumber = false}) {
    if (value == null || value.isEmpty || value.trim().isEmpty)
      return 'Polje ne smije biti prazno';

    if (isEmail) {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) return 'Neispravan email';
    }

    if (isNumber && (!value.contains(RegExp(r'^[0-9]+$')) || value.length < 6))
      return 'Unesite valjan broj';

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
      _toggleProfileEditing();
    }
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Promijeni lozinku'),
          content: Form(
            key: _changePasswordFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _currentPasswordController,
                    decoration: InputDecoration(labelText: 'Trenutna lozinka'),
                    obscureText: true,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Polje ne smije biti prazno';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(labelText: 'Nova lozinka'),
                    obscureText: true,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Polje ne smije biti prazno';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration:
                        InputDecoration(labelText: 'Potvrdi novu lozinku'),
                    obscureText: true,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Polje ne smije biti prazno';
                      } else if (value != _newPasswordController.text) {
                        return 'Lozinke se ne poklapaju';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Odustani'),
            ),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Promijeni'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePassword() async {
    if (_changePasswordFormKey.currentState?.validate() ?? false) {
      final success = await _userProvider.changePassword(
        User.userId!,
        _currentPasswordController.text,
        _newPasswordController.text,
        _confirmPasswordController.text,
      );
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lozinka je uspješno promijenjena.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Greška pri promjeni lozinke.')));
      }
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
            CompanySettingsForm(),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showChangePasswordDialog,
              child: Text('Promijeni lozinku'),
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

  void _showOrdersDialog() async {
    await _loadOrders();

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
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Detalji narudžbe #${order.id}'),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ime: ${order.user?.firstName ?? ''}'),
                    Text('Prezime: ${order.user?.lastName ?? ''}'),
                    Text(
                        'Broj transakcije: ${order.payment?.paymentNumber ?? 'N/A'}'),
                    SizedBox(height: 10),
                    Text('Proizvodi:'),
                    ListView.builder(
                      shrinkWrap: true,
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
                  ],
                ),
              ),
              actions: [
                if (order.status != OrderStatus.cancelled)
                  DropdownButton<OrderStatus>(
                    value: OrderStatus.values[order.status!],
                    onChanged: order.status == OrderStatus.cancelled.index
                        ? null
                        : (newValue) async {
                            var response = await _orderProvider.changeStatus(
                                order.id!, newValue!.index);
                            if (response?.statusCode == 200) {
                              setState(() {
                                order.status = newValue.index;
                              });

                              Navigator.pop(context);

                              _showMessageDialog(
                                title: 'Uspjeh',
                                message: 'Status narudžbe je uspješno ažuriran.',
                              );
                            } else {
                              Navigator.pop(context);

                              _showMessageDialog(
                                title: 'Greška',
                                message: 'Greška pri ažuriranju statusa narudžbe.',
                              );
                            }
                          },
                    items: OrderStatus.values.map((status) {
                      return DropdownMenuItem<OrderStatus>(
                        value: status,
                        child: Text(_getStatusText(status)),
                      );
                    }).toList(),
                    disabledHint: Text(_getStatusText(OrderStatus.cancelled)),
                  ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Zatvori'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMessageDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.inProgress:
        return 'U obradi';
      case OrderStatus.inDelivery:
        return 'U tijeku';
      case OrderStatus.delivered:
        return 'Dostavljeno';
      case OrderStatus.cancelled:
        return 'Otkazano';
    }
  }
}
