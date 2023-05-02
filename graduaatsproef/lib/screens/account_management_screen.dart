import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/dialogs/write_nfc_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/utils/encryption_util.dart';

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
  DateTime time = DateTime.now();
  final key = generateRandomBytes(32);

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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
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
    // Add the user to the database
    int userId = await DatabaseService().usersService.addUser(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        checkedIn: checkedin);

    // Create a new user
    Users newUser = Users(
      id: userId,
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      checkedIn: checkedin,
    );

    // Generate and encrypt the UID
    //int uidLength = 10;
    //Map<String, Uint8List> encryptedDataAndIV =
    //    generateAndEncryptUID(uidLength, key);
    final uid = Uuid().v4();
    final encryptedDataAndIV = encrypt(uid, key);

    // Create a new NFC card entry
    NfcCards newCard = NfcCards(
      card_id: 1,
      // Replace with a unique card ID, typically from your backend
      user_Id: userId,
      card_Uid: encryptedDataAndIV['encryptedData']!.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      encryption_Key: '',
    );

    // Add the card to the database
    await DatabaseService().nfcCardsService.addCard(
        userId: newUser.id,
        cardUid: encryptedDataAndIV['encryptedData']!.toString());

    // Save the key, iv, and time to the encryption table
    if (encryptedDataAndIV.containsKey('encryptedData') &&
        encryptedDataAndIV.containsKey('iv')) {
      time = DateTime.now();
      await DatabaseService().encryptionService.addEncryptionKey(
          userId: userId,
          key: encryptedDataAndIV['key']!,
          iv: encryptedDataAndIV['iv']!,
          createdAt: time);
    } else {
      print('error: Key or IV empty');
    }

    // Show the WriteNfcDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WriteNfcDialog(
          encryptedUid: encryptedDataAndIV['encryptedData'].toString(),
          time: time,
        );
      },
    );
  }
}
