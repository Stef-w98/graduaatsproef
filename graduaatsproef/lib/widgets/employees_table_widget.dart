import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';

class EmployeesTable extends StatelessWidget {
  final List<Users> users;
  final List<NfcCards> cards;

  EmployeesTable({required this.users, required this.cards});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      dataTextStyle: TextStyle(color: Colors.white),
      columns: [
        DataColumn(label: Text('User ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Card UID')),
      ],
      rows: users.map((user) {
        final card = cards.firstWhere((card) => card.user_Id == user.id,
            orElse: () => NfcCards(
                  card_id: 1,
                  user_Id: 1,
                  card_Uid: '-',
                  encryption_Key: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ));
        final cardUid = card.card_Uid;

        return DataRow(cells: [
          DataCell(Text('${user.id}')),
          DataCell(Text('${user.firstName} ${user.lastName}')),
          DataCell(Text('${user.email}')),
          DataCell(Text('${cardUid}')),
        ]);
      }).toList(),
    );
  }
}
