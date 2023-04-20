import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  final ValueChanged<DateTimeRange?> onDateRangeChanged;

  DateRangePicker({required this.onDateRangeChanged});

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime _selectedDate = DateTime.now();
  DateTimeRange? _selectedRange;

  void _updateSelectedRange(DateTimeRange newRange) {
    setState(() {
      _selectedRange = newRange;
    });
    widget.onDateRangeChanged(_selectedRange);
  }

  void _selectWeek(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 5),
      lastDate: DateTime(_selectedDate.year + 5),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      final weekStart =
          pickedDate.subtract(Duration(days: pickedDate.weekday - 1));
      final weekEnd = weekStart.add(Duration(days: 6));
      _updateSelectedRange(DateTimeRange(start: weekStart, end: weekEnd));
    }
  }

  void _selectMonth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 5),
      lastDate: DateTime(_selectedDate.year + 5),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      final monthStart = DateTime(pickedDate.year, pickedDate.month, 1);
      final monthEnd = DateTime(pickedDate.year, pickedDate.month + 1, 0);
      _updateSelectedRange(DateTimeRange(start: monthStart, end: monthEnd));
    }
  }

  void _selectYear(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 5),
      lastDate: DateTime(_selectedDate.year + 5),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      final yearStart = DateTime(pickedDate.year, 1, 1);
      final yearEnd = DateTime(pickedDate.year + 1, 1, 0);
      _updateSelectedRange(DateTimeRange(start: yearStart, end: yearEnd));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Selected Range: ${_selectedRange != null ? DateFormat('MMM d, yyyy').format(_selectedRange!.start) + ' - ' + DateFormat('MMM d, yyyy').format(_selectedRange!.end) : 'Not selected'}',
          style: TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectWeek(context),
              child: Text('Select Week'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => _selectMonth(context),
              child: Text('Select Month'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => _selectYear(context),
              child: Text('Select Year'),
            ),
          ],
        ),
      ],
    );
  }
}
