import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRange = '';

  void _selectWeek(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 5),
      lastDate: DateTime(_selectedDate.year + 5),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        final weekStart =
            pickedDate.subtract(Duration(days: pickedDate.weekday - 1));
        final weekEnd = weekStart.add(Duration(days: 6));
        _selectedRange =
            '${DateFormat('MMM d, yyyy').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}';
      });
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
      setState(() {
        _selectedDate = pickedDate;
        _selectedRange = DateFormat('MMMM yyyy').format(_selectedDate);
      });
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
      setState(() {
        _selectedDate = pickedDate;
        _selectedRange = DateFormat('yyyy').format(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Selected Range: $_selectedRange',
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
