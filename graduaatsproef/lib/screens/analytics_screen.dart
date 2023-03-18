import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1F24),
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Container(
        child: const Center(
          child: Text(
            'Analytics data will be displayed here',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
