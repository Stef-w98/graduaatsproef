import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/screens/update_user_screen.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/date_range_picker_widget.dart';
import 'package:graduaatsproef/widgets/user_contact_info_widget.dart';
import 'package:intl/intl.dart';

class EmployeeDetails extends StatefulWidget {
  late final Users user;
  final List<NfcCards> cards;
  final List<Attendance> attendances;

  EmployeeDetails({
    required this.user,
    required this.cards,
    required this.attendances,
  });

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  DateTimeRange? dateRange;
  final dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    final userAttendances = widget.attendances.where((attendance) {
      if (dateRange == null) {
        return attendance.userId == widget.user.id;
      }

      DateTime checkInTime = attendance.checkInTime;
      return attendance.userId == widget.user.id &&
          checkInTime.isAfter(dateRange!.start) &&
          checkInTime.isBefore(dateRange!.end);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F24),
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: UserContactInfoWidget(userId: widget.user.id.toString()),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateRangePicker(
                  onDateRangeChanged: (DateTimeRange? newDateRange) {
                    setState(() {
                      dateRange = newDateRange;
                    });
                  },
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      dataTextStyle: TextStyle(color: Colors.white),
                      columns: [
                        DataColumn(label: Text('Check In')),
                        DataColumn(label: Text('Check Out')),
                      ],
                      rows: userAttendances.map((attendance) {
                        return DataRow(cells: [
                          DataCell(Text(
                              dateFormatter.format(attendance.checkInTime))),
                          DataCell(Text(attendance.checkOutTime != null
                              ? dateFormatter.format(attendance.checkOutTime!)
                              : 'Not checked out')),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateAccountScreen(user: widget.user),
                ),
              );
              if (result != null && result['refresh'] == true) {
                setState(() {
                  // Update the user data using the result
                  widget.user = Users.fromMap(result['user']);
                  dateRange = null;
                });
              }
            },
            child: Text('Update User'),
          ),
        ],
      ),
    );
  }
}
