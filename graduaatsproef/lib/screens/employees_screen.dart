import 'package:flutter/material.dart';
import 'package:graduaatsproef/models/users_model.dart';
import 'package:graduaatsproef/models/nfc_cards_model.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/drawer_widget.dart';
import 'package:graduaatsproef/widgets/employees_table_widget.dart';
import 'package:graduaatsproef/widgets/searchbar_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  String _searchText = '';
  List<Users>? _users;
  List<NfcCards>? _cards;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final users = await DatabaseService().usersService.getUsers();
    final cards = await DatabaseService().nfcCardsService.getCards();
    setState(() {
      _users = users;
      _cards = cards;
    });
  }

  void _onSearchTextChanged(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  List<Users> _getFilteredUsers(List<Users> users) {
    if (_searchText.isEmpty) {
      return users;
    }

    return users
        .where((user) =>
            '${user.firstName} ${user.lastName}'
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            user.email.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_users == null || _cards == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1A1F24),
        appBar: AppBar(
          title: const Text('Employees'),
          backgroundColor: const Color(0xFF090F13),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final filteredUsers = _getFilteredUsers(_users!);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1F24),
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Employees'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBar(onSearchTextChanged: _onSearchTextChanged),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: EmployeesTable(users: filteredUsers, cards: _cards!),
            ),
          ),
        ],
      ),
    );
  }
}
