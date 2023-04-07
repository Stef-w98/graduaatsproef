import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/widgets/attendance_filter.dart';

class AttendanceData {
  final List<Attendance> attendanceList;
  final List<Users> employeeList;

  AttendanceData({required this.attendanceList, required this.employeeList});

  List<Map<String, dynamic>> mapAttendanceToSummary({
    required DateRange dateRange,
    required DateTime selectedDate,
  }) {
    AttendanceFilter attendanceFilter = AttendanceFilter(
      dateRange: dateRange,
      selectedDate: selectedDate,
    );

    List<Attendance> filteredAttendanceList =
        attendanceFilter.filterAttendanceList(attendanceList, dateRange);

    return employeeList.map((user) {
      Attendance? checkIn = filteredAttendanceList.firstWhere(
        (attendance) =>
            attendance.userId == user.id &&
            attendance.checkInTime == attendance.checkInTime,
        orElse: () => null,
      );
      Attendance? checkOut = filteredAttendanceList.firstWhere(
        (attendance) =>
            attendance.userId == user.id &&
            attendance.checkOutTime == attendance.checkOutTime,
        orElse: () => null,
      );

      String totalTimeWorked = '';
      if (checkIn != null && checkOut != null) {
        Duration timeWorked = checkOut.date.difference(checkIn.date);
        totalTimeWorked = AttendanceFilter.formatDuration(timeWorked);
      }

      return {
        'name': '${user.firstName} ${user.lastName}',
        'checkInTime': checkIn?.date.toLocal().toString() ?? '',
        'checkOutTime': checkOut?.date.toLocal().toString() ?? '',
        'totalTimeWorked': totalTimeWorked,
      };
    }).toList();
  }
}
