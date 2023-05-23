import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/widgets/employee_details_widget.dart';
import 'package:crypto/crypto.dart';

class EmployeesTable extends StatefulWidget {
  final List<Users> users;
  final List<NfcCards> cards;
  final List<Attendance> attendance;

  EmployeesTable({
    required this.users,
    required this.cards,
    required this.attendance,
  });

  @override
  _EmployeesTableState createState() => _EmployeesTableState();
}

class _EmployeesTableState extends State<EmployeesTable> {
  int? _hoverIndex;

  @override
  Widget build(BuildContext context) {
    var bytes = utf8.encode('1dfd65a8');
    var hashfull = sha512.convert(bytes);
    var hash = sha512256.convert(bytes);
    print('hash long: $hashfull');
    print('hash short: $hash');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        dataTextStyle: TextStyle(color: Colors.white),
        columns: const [
          DataColumn(label: Text('User ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Card UID')),
        ],
        rows: widget.users.asMap().entries.map((entry) {
          int index = entry.key;
          Users user = entry.value;
          final card = widget.cards.firstWhere(
            (card) => card.user_Id == user.id,
            orElse: () => NfcCards(
              card_id: 1,
              user_Id: 1,
              card_Uid: '-',
              encryption_Key: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
          final cardUid = card.card_Uid;

          return DataRow(
            cells: [
              DataCell(Text('${user.id}')),
              DataCell(Text('${user.firstName} ${user.lastName}')),
              DataCell(Text('${user.email}')),
              DataCell(Text('$cardUid')),
            ],
            color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
              if (index == _hoverIndex) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.1);
              }
              return Colors.black26;
            }),
          ).withInkWell(
            context,
            onRowHover: (isHovered) {
              setState(() {
                _hoverIndex = isHovered ? index : null;
              });
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeDetails(
                    user: user,
                    cards: widget.cards,
                    attendances: widget.attendance,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

extension DataRowWithInkWell on DataRow {
  DataRow withInkWell(BuildContext context,
      {required VoidCallback onTap, required ValueChanged<bool> onRowHover}) {
    final cells = this.cells.map((cell) {
      return DataCell(
        MouseRegion(
          onEnter: (_) => onRowHover(true),
          onExit: (_) => onRowHover(false),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: cell.child,
            ),
          ),
        ),
      );
    }).toList();

    return DataRow(
      cells: cells,
      color: this.color,
    );
  }
}
