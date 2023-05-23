import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/screens/update_user_screen.dart';
import 'package:graduaatsproef/widgets/date_range_picker_widget.dart';
import 'package:graduaatsproef/widgets/user_attendance_widget.dart';
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
  DateTime? startDate;
  DateTime? endDate;
  final dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    /*final userAttendances = widget.attendances.where((attendance) {
      if (startDate == null || endDate == null) {
        return attendance.userId == widget.user.id;
      }

      DateTime checkInTime = attendance.checkInTime;
      return attendance.userId == widget.user.id &&
          checkInTime.isAfter(startDate!) &&
          checkInTime.isBefore(endDate!);
    }).toList();*/

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F24),
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            // For larger screens (PC)
            return buildPCLayout();
          } else {
            // For smaller screens (Phones)
            return buildPhoneLayout();
          }
        },
      ),
    );
  }

  Widget buildPCLayout() {
    return Row(
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
                    startDate = newDateRange?.start;
                    endDate = newDateRange?.end;
                  });
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: AttendanceDataTableWidget(
                  userId: widget.user.id,
                  startDate: startDate,
                  endDate: endDate,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () async {
              Map<String, dynamic> result = await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateAccountScreen(user: widget.user),
                ),
              );
              if (result != null && result['refresh'] == true) {
                setState(() {
                  widget.user = Users.fromMap(result['user']);
                  startDate = null;
                  endDate = null;
                });
              }
            },
            icon: Icon(Icons.edit),
            label: Text('Update User'),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          DateRangePicker(
            onDateRangeChanged: (DateTimeRange? newDateRange) {
              setState(() {
                startDate = newDateRange?.start;
                endDate = newDateRange?.end;
              });
            },
          ),
          SizedBox(height: 16),
          AttendanceDataTableWidget(
            userId: widget.user.id,
            startDate: startDate,
            endDate: endDate,
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                Map<String, dynamic> result = await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateAccountScreen(user: widget.user),
                  ),
                );
                if (result != null && result['refresh'] == true) {
                  setState(() {
                    widget.user = Users.fromMap(result['user']);
                    startDate = null;
                    endDate = null;
                  });
                }
              },
              icon: Icon(Icons.edit),
              label: Text('Update User'),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: UserContactInfoWidget(userId: widget.user.id.toString()),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/screens/update_user_screen.dart';
import 'package:graduaatsproef/widgets/date_range_picker_widget.dart';
import 'package:graduaatsproef/widgets/user_attendance_widget.dart';
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
  DateTime? startDate;
  DateTime? endDate;
  final dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  Widget build(BuildContext context) {
    final userAttendances = widget.attendances.where((attendance) {
      if (startDate == null || endDate == null) {
        return attendance.userId == widget.user.id;
      }

      DateTime checkInTime = attendance.checkInTime;
      return attendance.userId == widget.user.id &&
          checkInTime.isAfter(startDate!) &&
          checkInTime.isBefore(endDate!);
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
                      startDate = newDateRange?.start;
                      endDate = newDateRange?.end;
                    });
                  },
                ),
                SizedBox(height: 16),
                Expanded(
                  child: AttendanceDataTableWidget(
                    userId: widget.user.id,
                    startDate: startDate,
                    endDate: endDate,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> result = await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateAccountScreen(user: widget.user),
                ),
              );
              if (result != null && result['refresh'] == true) {
                setState(() {
                  // Update the user data using the result
                  widget.user = Users.fromMap(result['user']);
                  startDate = null;
                  endDate = null;
                });
              }
            },
            child: Text('Update User'),
          ),
        ],
      ),
    );
  }
}*/
