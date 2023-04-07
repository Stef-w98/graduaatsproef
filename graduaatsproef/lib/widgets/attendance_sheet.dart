import 'package:flutter/material.dart';
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

/* import 'package:flutter/material.dart';
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
