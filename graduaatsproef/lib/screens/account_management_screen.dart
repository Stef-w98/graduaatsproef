import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/utils/form_style_util.dart';
import 'package:graduaatsproef/widgets/country_code_picker_widget.dart';
import 'package:graduaatsproef/widgets/dialogs/write_nfc_dialog.dart';
import 'package:graduaatsproef/widgets/drawer_widget.dart';

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
      drawer: const DrawerWidget(),
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
              SizedBox(
                height: 40.0,
                width: 350.0,
                child: TextFormField(
                  decoration: buildInputDecoration(
                      'First Name', 'Enter your first name'),
                  style: FormStyles.inputTextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a first name';
                    }
                    return null;
                  },
                  onSaved: (value) => _firstName = value ?? '',
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: 350.0,
                child: TextFormField(
                  decoration:
                      buildInputDecoration('Last Name', 'Enter your last name'),
                  style: FormStyles.inputTextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a last name';
                    }
                    return null;
                  },
                  onSaved: (value) => _lastName = value ?? '',
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: 350.0,
                child: TextFormField(
                  decoration: buildInputDecoration('Email', 'Enter your email'),
                  style: FormStyles.inputTextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value ?? '',
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: 350.0,
                child: TextFormField(
                  decoration:
                      buildInputDecoration('Address', 'Enter your address'),
                  style: FormStyles.inputTextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                  onSaved: (value) => _address = value ?? '',
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: 350.0,
                child: TextFormField(
                  decoration: buildInputDecoration('City', 'Enter your city'),
                  style: FormStyles.inputTextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  },
                  onSaved: (value) => _city = value ?? '',
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 40.0,
                width: 350.0,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration:
                      buildInputDecoration('Zip Code', 'Enter your zipcode'),
                  style: FormStyles.inputTextStyle(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a zip code';
                    }
                    return null;
                  },
                  onSaved: (value) => _zipcode = value ?? '',
                ),
              ),
              SizedBox(height: 16.0),
              CountryCodePickerWidget(
                onCountryChanged: (CountryCode code) {
                  setState(() {
                    _selectedCountry = code;
                    countryname = code.name.toString();
                  });
                },
                phoneController: _phoneController,
              ),
              const SizedBox(height: 16.0),
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
