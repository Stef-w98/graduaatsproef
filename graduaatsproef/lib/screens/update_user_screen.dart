import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/utils/form_style_util.dart';
import 'package:graduaatsproef/widgets/employee_details_widget.dart';

class UpdateAccountScreen extends StatefulWidget {
  final Users user;

  const UpdateAccountScreen({required this.user});

  @override
  _UpdateAccountScreenState createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _address = '';
  String _city = '';
  String _zipcode = '';
  String countryname = '';
  String countrydail = '';
  CountryCode _selectedCountry = CountryCode.fromCountryCode('BE');
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  String initialCountryCode = '';

  @override
  void initState() {
    super.initState();
    _firstName = widget.user.firstName;
    _lastName = widget.user.lastName;
    _email = widget.user.email;
    _addressController.text = widget.user.address!;
    _cityController.text = widget.user.city!;
    _zipcodeController.text = widget.user.zipcode!;
    countryname = widget.user.country!;
    countrydail = widget.user.phone!.split(' ')[0];
    _selectedCountry =
        CountryCode.fromDialCode(widget.user.phone!.split(' ')[0]);
    _phoneController.text = widget.user.phone!.split(' ')[1];
    initialCountryCode = _selectedCountry.code!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F24),
      appBar: AppBar(
        title: const Text('Update Account'),
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
                  initialValue: _firstName,
                  decoration: buildInputDecoration(
                    'First Name',
                    'Enter your first name',
                  ),
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
                  initialValue: _lastName,
                  decoration: buildInputDecoration(
                    'Last Name',
                    'Enter your last name',
                  ),
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
                  initialValue: _email,
                  decoration: buildInputDecoration(
                    'Email',
                    'Enter your email',
                  ),
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
                  controller: _addressController,
                  decoration: buildInputDecoration(
                    'Address',
                    'Enter your address',
                  ),
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
                  controller: _cityController,
                  decoration: buildInputDecoration(
                    'City',
                    'Enter your city',
                  ),
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
                  controller: _zipcodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: buildInputDecoration(
                    'Zip Code',
                    'Enter your zipcode',
                  ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170.0,
                    child: CountryCodePicker(
                      onChanged: (_selectedCountry) {
                        setState(() {
                          _selectedCountry = _selectedCountry;
                          countryname = _selectedCountry.name.toString();
                          countrydail = _selectedCountry.dialCode.toString();
                        });
                      },
                      initialSelection: initialCountryCode,
                      favorite: ['BE', 'NL', 'DE'],
                      showFlag: true,
                      showDropDownButton: true,
                      flagWidth: 40.0,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    width: 180.0,
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: buildInputDecoration(
                        'Phone',
                        'Enter your Phone number',
                      ),
                      style: FormStyles.inputTextStyle(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    int? userId = await _updateUser();
                    if (userId != null) {
                      showSnackbar('Update successful', Colors.green);
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetails(
                              user: widget.user,
                              cards: [],
                              attendances: [],
                            ),
                          ));
                    } else {
                      showSnackbar('Update failed', Colors.red);
                    }
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

  Future<int?> _updateUser() async {
    int? userId = await DatabaseService().usersService.updateUser(
          id: widget.user.id,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          address: _address,
          city: _city,
          zipcode: _zipcode.toString(),
          country: countryname,
          phone: '${countrydail} ${_phoneController.text}',
        );
    return userId;
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
