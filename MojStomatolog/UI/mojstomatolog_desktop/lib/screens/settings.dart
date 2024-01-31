import 'package:flutter/material.dart';
import 'package:mojstomatolog_desktop/providers/company_settings_provider.dart';
import 'package:mojstomatolog_desktop/providers/product_provider.dart';
import 'package:mojstomatolog_desktop/providers/user_provider.dart';
import 'package:mojstomatolog_desktop/providers/order_provider.dart';
import 'package:mojstomatolog_desktop/utils/util.dart';
import 'package:mojstomatolog_desktop/widgets/master_screen.dart';
import 'package:mojstomatolog_desktop/models/order.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isEditingProfile = false;
  bool isEditingCompany = false;

  final ProductProvider _productProvider = ProductProvider();
  final UserProvider _userProvider = UserProvider();
  final CompanySettingsProvider _companySettingsProvider =
      CompanySettingsProvider();
  final OrderProvider _orderProvider = OrderProvider();
  List<Order> _orders = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController workHoursFromController = TextEditingController();
  TextEditingController workHoursToController = TextEditingController();

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> companyFormKey = GlobalKey<FormState>();

  String initialName = User.firstName ?? '';
  String initialSurname = User.lastName ?? '';
  String initialEmail = User.email ?? '';
  String initialPhoneNumber = User.number ?? '';

  String initialWorkHoursFrom = '';
  String initialWorkHoursTo = '';

  @override
  void initState() {
    super.initState();

    nameController.text = initialName;
    surnameController.text = initialSurname;
    emailController.text = initialEmail;
    phoneNumberController.text = initialPhoneNumber;

    _initializeWorkHours();
    _loadOrders();
  }

  void _initializeWorkHours() async {
    try {
      final companySettings =
          await _companySettingsProvider.getByName('WorkingHours');

      if (companySettings['settingValue'] != null) {
        final workHours = companySettings['settingValue'].split('-');

        if (workHours.length == 2) {
          setState(() {
            initialWorkHoursFrom = workHours[0];
            initialWorkHoursTo = workHours[1];
          });
        }
      }
    } catch (e) {
      setState(() {
        initialWorkHoursFrom = '08:00';
        initialWorkHoursTo = '17:00';
      });
    }

    workHoursFromController.text = initialWorkHoursFrom;
    workHoursToController.text = initialWorkHoursTo;
  }

  void _updateWorkHours() async {
    final newWorkHours =
        '${workHoursFromController.text}-${workHoursToController.text}';
    await _companySettingsProvider.addOrUpdate('WorkingHours', newWorkHours);
  }

  bool isTimeFormatValid(String value) {
    final timePattern = RegExp(r'^\d{2}:\d{2}$');
    return timePattern.hasMatch(value);
  }

  void resetProfileFields() {
    setState(() {
      nameController.text = initialName;
      surnameController.text = initialSurname;
      emailController.text = initialEmail;
      phoneNumberController.text = initialPhoneNumber;
      profileFormKey.currentState?.reset();
    });
  }

  void resetCompanyFields() {
    setState(() {
      workHoursFromController.text = initialWorkHoursFrom;
      workHoursToController.text = initialWorkHoursTo;
      companyFormKey.currentState?.reset();
    });
  }

  void _retrainModel() async {
    try {
      await _productProvider.retrainModel();
    } catch (e) {
      print('Error retraining model: $e');
    }
  }

  Future<void> _loadOrders() async {
    try {
      final orders = await _orderProvider.get();
      setState(() {
        _orders = orders.results;
      });
    } catch (e) {
      print('Error loading orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentPage: 'Postavke',
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Postavke profila', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              Form(
                key: profileFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: nameController,
                              readOnly: !isEditingProfile,
                              enableInteractiveSelection: isEditingProfile,
                              decoration: InputDecoration(
                                labelText: 'Ime',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                if (!isEditingProfile) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: surnameController,
                              readOnly: !isEditingProfile,
                              enableInteractiveSelection: isEditingProfile,
                              decoration: InputDecoration(
                                labelText: 'Prezime',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                if (!isEditingProfile) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: emailController,
                              readOnly: !isEditingProfile,
                              enableInteractiveSelection: isEditingProfile,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value?.isEmpty ?? true)
                                  return 'Polje ne smije biti prazno';
                                final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (!emailRegex.hasMatch(value!))
                                  return 'Neispravan email';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                if (!isEditingProfile) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: phoneNumberController,
                              readOnly: !isEditingProfile,
                              enableInteractiveSelection: isEditingProfile,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value?.isEmpty ?? true)
                                  return 'Polje ne smije biti prazno';
                                if (value!.length < 6)
                                  return 'Unesite barem 6 brojeva';
                                if (!value.contains(RegExp(r'^[0-9]*$')))
                                  return 'Dozvoljen je samo numerički unos';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Broj telefona',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                if (!isEditingProfile) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (!isEditingProfile)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditingProfile = true;
                          });
                        },
                        child: Text('Uredi'),
                      ),
                    if (isEditingProfile)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditingProfile = false;
                                resetProfileFields();
                              });
                            },
                            child: Text('Odustani'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (profileFormKey.currentState?.validate() ??
                                  false) {
                                setState(() {
                                  isEditingProfile = false;
                                  initialName = nameController.text;
                                  initialSurname = surnameController.text;
                                  initialEmail = emailController.text;
                                  initialPhoneNumber =
                                      phoneNumberController.text;
                                });

                                dynamic user = {
                                  "firstName": nameController.text,
                                  "lastName": surnameController.text,
                                  "email": emailController.text,
                                  "number": phoneNumberController.text
                                };

                                User.firstName = nameController.text;
                                User.lastName = surnameController.text;
                                User.email = emailController.text;
                                User.number = phoneNumberController.text;

                                _userProvider.update(User.userId!, user);
                              }
                            },
                            child: Text('Spasi'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Text('Postavke kompanije', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
              Form(
                key: companyFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: workHoursFromController,
                              readOnly: !isEditingCompany,
                              enableInteractiveSelection: isEditingCompany,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Polje ne smije biti prazno';
                                }
                                if (!isTimeFormatValid(value)) {
                                  return 'Neispravan format vremena (XX:XX)';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Radno vrijeme - Od',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                if (!isEditingCompany) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: workHoursToController,
                              readOnly: !isEditingCompany,
                              enableInteractiveSelection: isEditingCompany,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Polje ne smije biti prazno';
                                }
                                if (!isTimeFormatValid(value)) {
                                  return 'Neispravan format vremena (XX:XX)';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Radno vrijeme - Do',
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                if (!isEditingCompany) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (!isEditingCompany)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditingCompany = true;
                          });
                        },
                        child: Text('Uredi'),
                      ),
                    if (isEditingCompany)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditingCompany = false;
                                resetCompanyFields();
                              });
                            },
                            child: Text('Odustani'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (companyFormKey.currentState?.validate() ??
                                  false) {
                                setState(() {
                                  isEditingCompany = false;
                                  initialWorkHoursFrom =
                                      workHoursFromController.text;
                                  initialWorkHoursTo =
                                      workHoursToController.text;
                                });

                                _updateWorkHours();
                              }
                            },
                            child: Text('Spasi'),
                          ),
                        ],
                      ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _retrainModel,
                      child: Text('Ponovo istreniraj model preporuke'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _loadOrders();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Narudžbe'),
                              content: Container(
                                width: double.maxFinite,
                                height: 300,
                                child: ListView.builder(
                                  itemCount: _orders.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final order = _orders[index];
                                    return ListTile(
                                      title: Text('Narudžba #${order.id}'),
                                      subtitle: Text(
                                          'Datum: ${DateFormat('dd.MM.yyyy').format(order.orderDate ?? DateTime.now())}'),
                                      onTap: () {
                                        _showOrderDetails(order);
                                      },
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Zatvori'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Pregledaj narudžbe'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
            height: 300,
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }
}
