import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class WriteNfcDialog extends StatefulWidget {
  final String encryptedUid;

  WriteNfcDialog({required this.encryptedUid});

  @override
  _WriteNfcDialogState createState() => _WriteNfcDialogState();
}

class _WriteNfcDialogState extends State<WriteNfcDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Write to NFC Card'),
      content: Text('Please hold your NFC card near the device.'),
      actions: [
        TextButton(
          onPressed: () async {
            try {
              await NfcManager.instance.startSession(
                onDiscovered: (NfcTag tag) async {
                  Ndef? ndef = Ndef.from(tag);
                  if (ndef != null) {
                    await ndef.write(NdefMessage([
                      NdefRecord.createText(widget.encryptedUid),
                    ]));
                    print('NFC tag written: ${widget.encryptedUid}');
                  }
                  await NfcManager.instance.stopSession();
                },
              );
            } on Exception catch (e) {
              print('Error writing NFC tag: $e');
            }
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Write'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
