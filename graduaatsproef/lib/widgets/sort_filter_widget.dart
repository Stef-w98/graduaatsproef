import 'package:flutter/material.dart';

enum SortOption {
  nameAscending,
  nameDescending,
  checkInAscending,
  checkInDescending,
  checkOutAscending,
  checkOutDescending,
  totalHoursAscending,
  totalHoursDescending,
}

class SortFilterWidget extends StatefulWidget {
  final ValueChanged<SortOption?> onSortOptionChanged;

  SortFilterWidget({required this.onSortOptionChanged});

  @override
  _SortFilterWidgetState createState() => _SortFilterWidgetState();
}

class _SortFilterWidgetState extends State<SortFilterWidget> {
  SortOption _selectedSortOption = SortOption.nameAscending;

  void _onSelectedSortOptionChanged(SortOption? newSortOption) {
    if (newSortOption != null) {
      setState(() {
        _selectedSortOption = newSortOption;
        widget.onSortOptionChanged(_selectedSortOption);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Color(0xFF1A1F24),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF1A1F24),
          ),
          child: DropdownButton<SortOption>(
            value: _selectedSortOption,
            style: TextStyle(color: Colors.white),
            onChanged: _onSelectedSortOptionChanged,
            items: [
              DropdownMenuItem(
                value: SortOption.nameAscending,
                child: Text('Name (A-Z)'),
              ),
              DropdownMenuItem(
                value: SortOption.nameDescending,
                child: Text('Name (Z-A)'),
              ),
              DropdownMenuItem(
                value: SortOption.checkInAscending,
                child: Text('Check-in Time (Ascending)'),
              ),
              DropdownMenuItem(
                value: SortOption.checkInDescending,
                child: Text('Check-in Time (Descending)'),
              ),
              DropdownMenuItem(
                value: SortOption.checkOutAscending,
                child: Text('Check-out Time (Ascending)'),
              ),
              DropdownMenuItem(
                value: SortOption.checkOutDescending,
                child: Text('Check-out Time (Descending)'),
              ),
              DropdownMenuItem(
                value: SortOption.totalHoursAscending,
                child: Text('Total Hours Worked (Ascending)'),
              ),
              DropdownMenuItem(
                value: SortOption.totalHoursDescending,
                child: Text('Total Hours Worked (Descending)'),
              ),
            ],
            icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
