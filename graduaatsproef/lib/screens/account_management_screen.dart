import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/dialogs/write_nfc_dialog.dart';
import '../models/nfc_cards_model.dart';
import '../utils/encryption_util.dart';
import '../utils/nfc_util.dart';

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
  final key = generateRandomBytes(32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F24),
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
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
    // Add the user to the database
    int userId = await DatabaseService()
        .usersService
        .addUser(firstName: _firstName, lastName: _lastName, email: _email);

    // Create a new user
    Users newUser = Users(
      id: userId,
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Generate and encrypt the UID
    int uidLength = 10;
    Map<String, Uint8List> encryptedDataAndIV =
        generateAndEncryptUID(uidLength, key);

    // Create a new NFC card entry
    NfcCards newCard = NfcCards(
      card_id: 1,
      // Replace with a unique card ID, typically from your backend
      user_Id: userId,
      card_Uid: encryptedDataAndIV['encryptedData'].toString(),
      encryption_Key: key.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Add the card to the database
    await DatabaseService()
        .nfcCardsService
        .addCard(userId: newUser.id, cardUid: newCard.card_Uid);

    // Show the WriteNfcDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WriteNfcDialog(encryptedUid: newCard.card_Uid);
      },
    ).then((_) {
      // Show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User created and UID written to NFC card')),
      );
    });
  }
}
