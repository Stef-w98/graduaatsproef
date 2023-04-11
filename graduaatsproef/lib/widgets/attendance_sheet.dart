import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/models/users_model.dart';

class AttendanceSheet extends StatelessWidget {
  final List<Attendance> attendances;
  final List<Users> users;

  AttendanceSheet({required this.attendances, required this.users});

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}h';
  }

  String _formatTotalHours(Duration duration) {
    String hours = duration.inHours.toString();
    int minutes = duration.inMinutes.remainder(60);
    if (minutes == 0) {
      return '${hours}h';
    } else {
      return '${hours}:${minutes.toString().padLeft(2, '0')}h';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 600;

    double nameColumnWidth = isLargeScreen ? 200 : screenWidth * 0.4;
    double otherColumnWidth = isLargeScreen ? 150 : screenWidth * 0.2;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          dataTextStyle: TextStyle(color: Colors.white),
          columns: [
            DataColumn(
                label: Container(width: nameColumnWidth, child: Text('Name'))),
            DataColumn(
                label: Container(
                    width: otherColumnWidth, child: Text('Checkin Hour'))),
            DataColumn(
                label: Container(
                    width: otherColumnWidth, child: Text('Checkout Hour'))),
            DataColumn(
                label: Container(
                    width: otherColumnWidth, child: Text('Total Hours'))),
          ],
          rows: attendances.map((attendance) {
            final user =
                users.firstWhere((user) => user.id == attendance.userId);
            final checkInHour = _formatTime(attendance.checkInTime.toLocal());
            final checkOutHour = attendance.checkOutTime != null
                ? _formatTime(attendance.checkOutTime!.toLocal())
                : '-';
            final totalHours = attendance.checkOutTime != null
                ? _formatTotalHours(
                    attendance.checkOutTime!.difference(attendance.checkInTime))
                : '0h';

            return DataRow(cells: [
              DataCell(Container(
                  width: nameColumnWidth,
                  child: Text('${user.firstName} ${user.lastName}'))),
              DataCell(Container(
                  width: otherColumnWidth, child: Text('$checkInHour'))),
              DataCell(Container(
                  width: otherColumnWidth, child: Text('$checkOutHour'))),
              DataCell(Container(
                  width: otherColumnWidth, child: Text('$totalHours'))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/utils/attendance_data.dart';
import 'package:graduaatsproef/widgets/AttendanceFilterBar.dart';
import 'package:graduaatsproef/widgets/attendance_filter.dart';

class AttendanceSheet extends StatefulWidget {
  final List<Attendance> attendanceList;
  final List<Users> employeeList;

  const AttendanceSheet({
    Key? key,
    required this.attendanceList,
    required this.employeeList,
  }) : super(key: key);

  @override
  _AttendanceSheetState createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  late AttendanceData attendanceData;
  late List<Map<String, dynamic>> attendanceSummary;

  @override
  void initState() {
    super.initState();
    attendanceData = AttendanceData(
      attendanceList: widget.attendanceList,
      employeeList: widget.employeeList,
    );
    attendanceSummary = attendanceData.mapAttendanceToSummary(
      dateRange: DateRange.day,
      selectedDate: DateTime.now(),
    );
  }

  void _onDateRangeChanged(DateRange dateRange) {
    setState(() {
      attendanceSummary = attendanceData.mapAttendanceToSummary(
        dateRange: dateRange,
        selectedDate: DateTime.now(),
      );
    });
  }
  //////////
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AttendanceFilterBar(
          onDateRangeChanged: _onDateRangeChanged,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: attendanceSummary.length,
            itemBuilder: (context, index) {
              final item = attendanceSummary[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item['name']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${item['checkInTime']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${item['checkOutTime']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${item['totalTimeWorked']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
///////////////
import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/utils/attendance_data.dart';
import 'package:graduaatsproef/widgets/AttendanceFilterBar.dart';
import 'package:graduaatsproef/widgets/attendance_filter.dart';

class AttendanceSheet extends StatefulWidget {
  final List<Users> employeeList;
  final Function(Users) onTap;

  const AttendanceSheet({
    Key? key,
    required this.employeeList,
    required this.onTap,
  }) : super(key: key);

  @override
  _AttendanceSheetState createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<AttendanceSheet> {
  late Future<List<Attendance>> _attendanceListFuture;

  final AttendanceFilter _attendanceFilter =
      AttendanceFilter(dateRange: DateRange.week);

  @override
  void initState() {
    super.initState();
    _attendanceListFuture = _getAttendanceList();
  }

  Future<List<Attendance>> _getAttendanceList() =>
      DatabaseService().attendanceService.getAttendance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Attendance>>(
      future: _attendanceListFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final attendanceList = snapshot.data!;
          final filteredAttendanceList =
              _attendanceFilter.filterAttendanceList(attendanceList);
          final attendanceData = AttendanceData(
            attendanceList: filteredAttendanceList,
            employeeList: widget.employeeList,
          );

          return Column(
            children: [
              AttendanceFilterBar(
                onDateRangeChanged: (dateRange) {
                  setState(() {
                    _attendanceFilter.dateRange = dateRange;
                  });
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Attendance Sheet',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: attendanceData.tableWidth,
                              child: DataTable(
                                headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                dataTextStyle:
                                    const TextStyle(color: Colors.white),
                                columns: attendanceData.columns,
                                rows: attendanceData.rows,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
    );
  }
} */
