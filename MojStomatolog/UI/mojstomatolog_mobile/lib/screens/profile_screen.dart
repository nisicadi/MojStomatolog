import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/providers/user_provider.dart';
import 'package:mojstomatolog_mobile/screens/login_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      currentIndex: 3,
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorText: isContactNumberValid
                              ? null
                              : contactNumberErrorMessage,
                          errorStyle: TextStyle(color: Colors.red),
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
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (!editMode)
                          ElevatedButton(
                            onPressed: toggleEditMode,
                            child: Text("Uredi"),
                          )
                        else
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: saveChanges,
                                child: Text("Spasi"),
                              ),
                              SizedBox(width: 16.0),
                              ElevatedButton(
                                onPressed: toggleEditMode,
                                child: Text("Odustani"),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Implement
                          },
                          child: Text("Moje narudžbe"),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Implement
                          },
                          child: Text("Moji termini"),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Center(
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
