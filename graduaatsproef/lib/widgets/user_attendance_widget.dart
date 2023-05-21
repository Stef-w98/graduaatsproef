import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:intl/intl.dart';
import 'package:graduaatsproef/services/database/database_service.dart';

class AttendanceDataTableWidget extends StatefulWidget {
  final int userId;
  final DateTime? startDate; // Add the startDate parameter
  final DateTime? endDate; // Add the endDate parameter

  AttendanceDataTableWidget({
    required this.userId,
    this.startDate,
    this.endDate,
  });

  @override
  _AttendanceDataTableWidgetState createState() =>
      _AttendanceDataTableWidgetState();
}

class _AttendanceDataTableWidgetState extends State<AttendanceDataTableWidget> {
  List<Attendance> attendances = [];
  final dateFormatter = DateFormat('yyyy-MM-dd');
  final timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  void fetchAttendanceData() async {
    // Perform database call to retrieve attendance data based on userId
    List<Attendance> fetchedAttendances =
        await getAttendanceByUserId(widget.userId);
    setState(() {
      attendances = fetchedAttendances;
    });
  }

  Future<List<Attendance>> getAttendanceByUserId(int userId) async {
    return await DatabaseService()
        .attendanceService
        .getAttendanceByUserId(userId);
  }

  List<Attendance> filterAttendances() {
    if (widget.startDate == null || widget.endDate == null) {
      return attendances;
    } else {
      return attendances.where((attendance) {
        DateTime checkInTime = attendance.checkInTime;
        return checkInTime.isAfter(widget.startDate!) &&
            checkInTime.isBefore(widget.endDate!);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Attendance> filteredAttendances = filterAttendances();

    return SingleChildScrollView(
      child: DataTable(
        headingTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        dataTextStyle: TextStyle(color: Colors.white),
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Check In')),
          DataColumn(label: Text('Check Out')),
        ],
        rows: filteredAttendances.map((attendance) {
          return DataRow(cells: [
            DataCell(Text(dateFormatter.format(attendance.checkInTime))),
            DataCell(Text(attendance.checkInTime != null
                ? timeFormatter.format(attendance.checkInTime!)
                : 'Not checked in')),
            DataCell(Text(attendance.checkOutTime != null
                ? timeFormatter.format(attendance.checkOutTime!)
                : 'Not checked out')),
          ]);
        }).toList(),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:intl/intl.dart';
import 'package:graduaatsproef/services/database/database_service.dart';

class AttendanceDataTableWidget extends StatefulWidget {
  final int userId;
  final DateTimeRange? dateRange; // Add the dateRange parameter

  AttendanceDataTableWidget({required this.userId, this.dateRange});

  @override
  _AttendanceDataTableWidgetState createState() =>
      _AttendanceDataTableWidgetState();
}

class _AttendanceDataTableWidgetState extends State<AttendanceDataTableWidget> {
  List<Attendance> attendances = [];
  final dateFormatter = DateFormat('yyyy-MM-dd');
  final timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  void fetchAttendanceData() async {
    // Perform database call to retrieve attendance data based on userId
    List<Attendance> fetchedAttendances =
        await getAttendanceByUserId(widget.userId);
    setState(() {
      attendances = fetchedAttendances;
    });
  }

  Future<List<Attendance>> getAttendanceByUserId(int userId) async {
    return await DatabaseService()
        .attendanceService
        .getAttendanceByUserId(userId);
  }

  List<Attendance> filterAttendances() {
    if (widget.dateRange == null) {
      return attendances;
    } else {
      return attendances.where((attendance) {
        DateTime checkInTime = attendance.checkInTime;
        return checkInTime.isAfter(widget.dateRange!.start) &&
            checkInTime.isBefore(widget.dateRange!.end);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Attendance> filteredAttendances = filterAttendances();

    return SingleChildScrollView(
      child: DataTable(
        headingTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        dataTextStyle: TextStyle(color: Colors.white),
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Check In')),
          DataColumn(label: Text('Check Out')),
        ],
        rows: filteredAttendances.map((attendance) {
          return DataRow(cells: [
            DataCell(Text(dateFormatter.format(attendance.checkInTime))),
            DataCell(Text(attendance.checkInTime != null
                ? timeFormatter.format(attendance.checkInTime!)
                : 'Not checked in')),
            DataCell(Text(attendance.checkOutTime != null
                ? timeFormatter.format(attendance.checkOutTime!)
                : 'Not checked out')),
          ]);
        }).toList(),
      ),
    );
  }
}*/
