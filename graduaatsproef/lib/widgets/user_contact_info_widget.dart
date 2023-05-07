import 'package:flutter/material.dart';
import 'package:graduaatsproef/services/database/database_service.dart';

class UserContactInfoWidget extends StatefulWidget {
  final String userId;

  UserContactInfoWidget({required this.userId});

  @override
  _UserContactInfoWidgetState createState() => _UserContactInfoWidgetState();
}

class _UserContactInfoWidgetState extends State<UserContactInfoWidget> {
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final userInfo =
        await DatabaseService().usersService.getUserById(widget.userId);
    setState(() {
      this.userInfo = userInfo!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 10.0),
            Text(
              '${userInfo['first_name']} ${userInfo['last_name']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Icon(Icons.email),
            SizedBox(width: 10.0),
            Text(
              '${userInfo['email']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userInfo['address']}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '${userInfo['city']}, ${userInfo['country']} ${userInfo['zip_code']}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Icon(Icons.phone),
            SizedBox(width: 10.0),
            Text(
              '${userInfo['phone']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ],
    );
  }
}
