import 'package:intl/intl.dart';
import 'package:graduaatsproef/models/attendance_model.dart';

enum DateRange { day, week, month }

class AttendanceFilter {
  final DateRange dateRange;
  final DateTime? selectedDate;

  AttendanceFilter({required this.dateRange, this.selectedDate});

  bool isInDateRange(DateTime date, DateRange dateRange) {
    DateTime now = DateTime.now();
    DateTime startDate, endDate;

    switch (dateRange) {
      case DateRange.day:
        startDate = DateTime(now.year, now.month, now.day);
        endDate = startDate.add(Duration(days: 1));
        break;
      case DateRange.week:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate.add(Duration(days: 7));
        break;
      case DateRange.month:
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 1);
        break;
    }

    return date.isAfter(startDate) && date.isBefore(endDate);
  }

  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes - hours * 60)
        .toString()
        .padLeft(2, '0'); // Add leading zero if necessary
    return '$hours:$minutes';
  }

  List<Attendance> filterAttendanceList(
      List<Attendance> attendanceList, DateRange dateRange) {
    dateRange = dateRange ?? this.dateRange;
    return attendanceList
        .where((attendance) => isInDateRange(attendance.date, dateRange))
        .toList();
  }
}
