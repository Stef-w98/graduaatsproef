import 'package:flutter/material.dart';

class ReadNfcDialog extends StatelessWidget {
  final String uid;
  final String dateTimeString;

  const ReadNfcDialog({
    Key? key,
    required this.uid,
    required this.dateTimeString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('NFC Card Read'),
      content: Text(
        'UID: $uid\nDateTime: ${dateTimeString.substring(3)}',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
