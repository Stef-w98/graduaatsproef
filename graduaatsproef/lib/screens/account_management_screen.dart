import 'package:flutter/material.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);

  @override
  _AccountManagementScreenState createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final int _currentIndex = 3;
  // Define your form key and text editing controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nfcController = TextEditingController();

  // Define your validation functions
  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateNFC(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an NFC card number';
    }
    return null;
  }

  // Define your save function
  void _saveAccount() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save the account data to your database
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: _validateName,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nfcController,
                decoration: InputDecoration(
                  labelText: 'NFC Card Number',
                ),
                validator: _validateNFC,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveAccount,
                child: Text('Save Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
