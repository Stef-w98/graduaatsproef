import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/country_code_picker_widget.dart';
import 'package:graduaatsproef/widgets/dialogs/write_nfc_dialog.dart';

class AccountManagementScreen extends StatefulWidget {
  @override
  _AccountManagementScreenState createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _address = '';
  String _city = '';
  String _zipcode = '';
  String countryname = '';
  CountryCode _selectedCountry = CountryCode.fromCountryCode('BE');
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F24),
      appBar: AppBar(
        title: const Text('Add Account'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
                onSaved: (value) => _city = value ?? '',
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Zip Code',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a zip code';
                  }
                  return null;
                },
                onSaved: (value) => _zipcode = value ?? '',
              ),
              CountryCodePickerWidget(
                onCountryChanged: (CountryCode code) {
                  setState(() {
                    _selectedCountry = code;
                    countryname = code.name.toString();
                  });
                },
                phoneController: _phoneController,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  print(_selectedCountry);
                  print(countryname);
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _createUserAndWriteCard();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUserAndWriteCard() async {
    bool checkedin = false;
    int userId = await DatabaseService().usersService.addUser(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        address: _address,
        city: _city,
        country: _selectedCountry.name.toString(),
        zipcode: _zipcode,
        phone:
            '${_selectedCountry.dialCode.toString()} ${_phoneController.text.toString()}',
        checkedIn: checkedin);

    Users newUser = Users(
      id: userId,
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      address: _address,
      city: _city,
      country: _selectedCountry.name.toString(),
      zipcode: _zipcode,
      phone:
          '${_selectedCountry.dialCode.toString()} ${_phoneController.text.toString()}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      checkedIn: checkedin,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WriteNfcDialog(userId: newUser.id);
      },
    );
  }
}
