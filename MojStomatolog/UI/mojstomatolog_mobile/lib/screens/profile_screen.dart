import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojstomatolog_mobile/providers/user_provider.dart';
import 'package:mojstomatolog_mobile/screens/login_screen.dart';
import 'package:mojstomatolog_mobile/screens/my_appointments_screen.dart';
import 'package:mojstomatolog_mobile/screens/orders_screen.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editMode = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final UserProvider _userProvider = UserProvider();
  dynamic user = {};

  bool isEmailValid = true;
  bool isContactNumberValid = true;
  String emailErrorMessage = '';
  String contactNumberErrorMessage = '';

  @override
  void initState() {
    _initializeUserData();
    super.initState();
  }

  Future<void> _initializeUserData() async {
    try {
      user = await _userProvider.getById(User.userId!);

      firstNameController.text = user["firstName"] ?? '';
      lastNameController.text = user["lastName"] ?? '';
      contactNumberController.text = user["number"] ?? '';
      emailController.text = user["email"] ?? '';
    } catch (e) {
      print("Error initializing user data: $e");
    }
  }

  void toggleEditMode() {
    setState(() {
      editMode = !editMode;
    });
  }

  void saveChanges() async {
    isEmailValid = _validateEmail(emailController.text);
    isContactNumberValid = _validateContactNumber(contactNumberController.text);

    if (isEmailValid && isContactNumberValid) {
      user["firstName"] = firstNameController.text;
      user["lastName"] = lastNameController.text;
      user["number"] = contactNumberController.text;
      user["email"] = emailController.text;

      try {
        await _userProvider.update(User.userId!, user);
      } catch (e) {
        print("Error saving user data: $e");
      }
      toggleEditMode();
    } else {
      setState(() {});
    }
  }

  bool _validateEmail(String email) {
    if (email.isEmpty ||
        !RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
            .hasMatch(email)) {
      emailErrorMessage = 'Unesite validnu email adresu';
      return false;
    }
    emailErrorMessage = '';
    return true;
  }

  bool _validateContactNumber(String number) {
    if (number.isEmpty ||
        number.length < 6 ||
        !RegExp(r'^[0-9]+$').hasMatch(number)) {
      contactNumberErrorMessage = 'Unesite broj sa najmanje 6 cifara';
      return false;
    }
    contactNumberErrorMessage = '';
    return true;
  }

  void _showChangePasswordDialog() async {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    String currentPasswordError = '';
    String newPasswordError = '';
    String confirmPasswordError = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Promijeni šifru'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Trenutna šifra',
                        errorText: currentPasswordError.isEmpty
                            ? null
                            : currentPasswordError,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Nova šifra',
                        errorText:
                            newPasswordError.isEmpty ? null : newPasswordError,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Potvrdi šifru',
                        errorText: confirmPasswordError.isEmpty
                            ? null
                            : confirmPasswordError,
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Odustani'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Promijeni'),
                  onPressed: () {
                    setState(() {
                      currentPasswordError = '';
                      newPasswordError = '';
                      confirmPasswordError = '';

                      if (currentPasswordController.text.trim().isEmpty) {
                        currentPasswordError = 'Unesite trenutnu šifru';
                      }

                      if (newPasswordController.text.trim().isEmpty) {
                        newPasswordError = 'Unesite novu šifru';
                      }

                      if (confirmPasswordController.text !=
                          newPasswordController.text) {
                        confirmPasswordError = 'Šifre se ne podudaraju';
                      }
                    });

                    if (currentPasswordError.isEmpty &&
                        newPasswordError.isEmpty &&
                        confirmPasswordError.isEmpty) {
                      _userProvider
                          .changePassword(
                              User.userId!,
                              currentPasswordController.text,
                              newPasswordController.text,
                              confirmPasswordController.text)
                          .then((success) {
                        if (success) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Šifra uspješno promijenjena')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Greška pri promjeni šifre')));
                        }
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<void>(
            future: _initializeUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ime:"),
                    SizedBox(height: 8.0),
                    if (!editMode)
                      Text(user["firstName"] ?? '')
                    else
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    SizedBox(height: 16.0),
                    Text("Prezime:"),
                    SizedBox(height: 8.0),
                    if (!editMode)
                      Text(user["lastName"] ?? '')
                    else
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    SizedBox(height: 16.0),
                    Text("Kontakt broj:"),
                    SizedBox(height: 8.0),
                    if (!editMode)
                      Text(user["number"] ?? '')
                    else
                      TextFormField(
                        controller: contactNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorText: isContactNumberValid
                              ? null
                              : contactNumberErrorMessage,
                        ),
                      ),
                    SizedBox(height: 16.0),
                    Text("Email:"),
                    SizedBox(height: 8.0),
                    if (!editMode)
                      Text(user["email"] ?? '')
                    else
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorText: isEmailValid ? null : emailErrorMessage,
                        ),
                      ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!editMode)
                            toggleEditMode();
                          else
                            saveChanges();
                        },
                        child: Text(editMode ? "Spasi" : "Uredi"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: _showChangePasswordDialog,
                        child: Text("Promijeni šifru"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrdersPage(),
                          ));
                        },
                        child: Text("Moje narudžbe"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyAppointmentsPage(),
                          ));
                        },
                        child: Text("Moji termini"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _userProvider.logOut();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text("Odjava"),
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
