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
    return Container(
      width: 300.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[900],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '${userInfo['first_name']} ${userInfo['last_name']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Address:',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '${userInfo['address']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                '        ${userInfo['city']}, ${userInfo['zip_code']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              Text(
                '        ${userInfo['country']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Email:',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '${userInfo['email']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Phone:',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '${userInfo['phone']}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
