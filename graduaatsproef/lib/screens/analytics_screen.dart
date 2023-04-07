import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/attendance_sheet.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F24),
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          DatabaseService().usersService.getUsers(),
          DatabaseService().attendanceService.getAttendance(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final employeeList = snapshot.data![0] as List<Users>;
            final attendanceList = snapshot.data![1] as List<Attendance>;

            // Print the fetched data to see if it's in the expected format
            print('Employee List:');
            employeeList.forEach((employee) => print(employee.toString()));
            print('Attendance List:');
            attendanceList
                .forEach((attendance) => print(attendance.toString()));

            return AttendanceSheet(
              employeeList: employeeList,
              attendanceList: attendanceList,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
