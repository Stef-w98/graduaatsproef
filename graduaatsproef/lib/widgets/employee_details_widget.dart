import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';

class EmployeeDetails extends StatelessWidget {
  final Users user;
  final List<NfcCards> cards;

  EmployeeDetails({required this.user, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${user.firstName} ${user.lastName}'),
            Text('Email: ${user.email}'),
            // Add your dropdown here
          ],
        ),
      ),
    );
  }
}
