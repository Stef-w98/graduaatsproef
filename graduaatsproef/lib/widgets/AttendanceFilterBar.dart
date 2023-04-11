/*import 'package:flutter/material.dart';
import 'package:graduaatsproef/widgets/attendance_filter.dart';

class AttendanceFilterBar extends StatefulWidget {
  final void Function(DateRange) onDateRangeChanged;

  const AttendanceFilterBar({
    Key? key,
    required this.onDateRangeChanged,
  }) : super(key: key);

  @override
  _AttendanceFilterBarState createState() => _AttendanceFilterBarState();
}

class _AttendanceFilterBarState extends State<AttendanceFilterBar> {
  DateRange _selectedDateRange = DateRange.week;

  void _handleDateRangeChanged(DateRange dateRange) {
    setState(() {
      _selectedDateRange = dateRange;
    });
    widget.onDateRangeChanged(dateRange);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => _handleDateRangeChanged(DateRange.day),
          style: TextButton.styleFrom(
            backgroundColor: _selectedDateRange == DateRange.day
                ? Theme.of(context).primaryColor
                : Colors.grey.shade800,
          ),
          child: Text(
            'Day',
            style: TextStyle(
              color: _selectedDateRange == DateRange.day
                  ? Colors.white
                  : Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        TextButton(
          onPressed: () => _handleDateRangeChanged(DateRange.week),
          style: TextButton.styleFrom(
            backgroundColor: _selectedDateRange == DateRange.week
                ? Theme.of(context).primaryColor
                : Colors.grey.shade800,
          ),
          child: Text(
            'Week',
            style: TextStyle(
              color: _selectedDateRange == DateRange.week
                  ? Colors.white
                  : Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        TextButton(
          onPressed: () => _handleDateRangeChanged(DateRange.month),
          style: TextButton.styleFrom(
            backgroundColor: _selectedDateRange == DateRange.month
                ? Theme.of(context).primaryColor
                : Colors.grey.shade800,
          ),
          child: Text(
            'Month',
            style: TextStyle(
              color: _selectedDateRange == DateRange.month
                  ? Colors.white
                  : Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }
}*/
