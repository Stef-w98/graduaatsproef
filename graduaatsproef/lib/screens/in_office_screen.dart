import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/attendance_sheet.dart';
import 'package:graduaatsproef/widgets/date_picker_widget.dart';
import 'package:graduaatsproef/widgets/drawer_widget.dart';
import 'package:graduaatsproef/widgets/sort_filter_widget.dart';

class InOfficeScreen extends StatefulWidget {
  @override
  _InOfficeScreenState createState() => _InOfficeScreenState();
}

class _InOfficeScreenState extends State<InOfficeScreen> {
  DateTime _selectedDate = DateTime.now();
  SortOption _selectedSortOption = SortOption.nameAscending;

  List<Attendance> _applySorting(
      List<Attendance> attendances, List<Users> users) {
    List<Attendance> filteredAttendances = attendances.where((attendance) {
      return attendance.date.year == _selectedDate.year &&
          attendance.date.month == _selectedDate.month &&
          attendance.date.day == _selectedDate.day;
    }).toList();

    List<Attendance> sortedAttendances =
        List<Attendance>.from(filteredAttendances);

    Map<int, Users> usersMap = {
      for (var user in users) user.id: user,
    };

    sortedAttendances.sort((a, b) {
      Users userA = usersMap[a.userId]!;
      Users userB = usersMap[b.userId]!;

      switch (_selectedSortOption) {
        case SortOption.nameAscending:
          return userA.firstName
              .toLowerCase()
              .compareTo(userB.firstName.toLowerCase());
        case SortOption.nameDescending:
          return userB.firstName
              .toLowerCase()
              .compareTo(userA.firstName.toLowerCase());
        case SortOption.checkInAscending:
          return a.checkInTime.compareTo(b.checkInTime);
        case SortOption.checkInDescending:
          return b.checkInTime.compareTo(a.checkInTime);
        case SortOption.checkOutAscending:
          return a.checkOutTime?.compareTo(b.checkOutTime ?? DateTime.now()) ??
              1;
        case SortOption.checkOutDescending:
          return b.checkOutTime?.compareTo(a.checkOutTime ?? DateTime.now()) ??
              -1;
        case SortOption.totalHoursAscending:
          return (a.checkOutTime?.difference(a.checkInTime).inMinutes ?? 0)
              .compareTo(
                  (b.checkOutTime?.difference(b.checkInTime).inMinutes ?? 0));
        case SortOption.totalHoursDescending:
          return (b.checkOutTime?.difference(b.checkInTime).inMinutes ?? 0)
              .compareTo(
                  (a.checkOutTime?.difference(a.checkInTime).inMinutes ?? 0));
      }
    });

    return sortedAttendances;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
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

            // Apply sorting
            final sortedAttendanceList =
                _applySorting(attendanceList, employeeList);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DatePickerWidget(onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SortFilterWidget(onSortOptionChanged: (newSortOption) {
                    setState(() {
                      _selectedSortOption = newSortOption!;
                    });
                  }),
                ),
                Expanded(
                  child: AttendanceSheet(
                    users: employeeList,
                    attendances: sortedAttendanceList,
                  ),
                ),
              ],
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
