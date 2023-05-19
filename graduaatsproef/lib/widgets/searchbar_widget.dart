import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchTextChanged;

  SearchBar({required this.onSearchTextChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    widget.onSearchTextChanged(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: TextStyle(color: Colors.white), // Set text color to white
      decoration: InputDecoration(
        hintText: 'Search for an employee',
        hintStyle: TextStyle(color: Colors.white),
        // Set hint text color to white
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        // Set prefix icon color to white
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        // Set background color to white with opacity
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          // Set border color to white
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          // Set enabled border color to white
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          // Set focused border color to white
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: (value) => _onSearchTextChanged(),
    );
  }
}
