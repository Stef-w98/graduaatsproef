import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/widgets/date_range_picker_widget.dart';

class EmployeeDetails extends StatelessWidget {
  final Users user;
  final List<NfcCards> cards;

  EmployeeDetails({required this.user, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F24),
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${user.firstName} ${user.lastName}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Email: ${user.email}',
              style: TextStyle(color: Colors.white),
            ),
            // Add your dropdown here
            DateRangePicker(),
          ],
        ),
      ),
    );
  }
}
