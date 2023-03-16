import 'package:flutter/material.dart';

class CheckInOutScreen extends StatelessWidget {
  const CheckInOutScreen({Key? key}) : super(key: key);
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check In/Out'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap your NFC card to check in/out',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(Icons.nfc),
              iconSize: 72,
              onPressed: () {
                // TODO: Implement NFC card reading and data saving logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
