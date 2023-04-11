import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;

  DatePickerWidget({required this.onDateChanged});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _selectedDate = DateTime.now();

  void _onPreviousDayPressed() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
      widget.onDateChanged(_selectedDate);
    });
  }

  void _onNextDayPressed() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
      widget.onDateChanged(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _onPreviousDayPressed,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blue, width: 2.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != _selectedDate) {
                setState(() {
                  _selectedDate = picked;
                  widget.onDateChanged(_selectedDate);
                });
              }
            },
            child: Text(
              '${_selectedDate.toLocal()}'.split(' ')[0],
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: _onNextDayPressed,
        ),
      ],
    );
  }
}
