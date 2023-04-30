import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

class WriteNfcDialog extends StatefulWidget {
  final String encryptedUid;
  final DateTime time;

  WriteNfcDialog({required this.encryptedUid, required this.time});

  @override
  _WriteNfcDialogState createState() => _WriteNfcDialogState();
}

class _WriteNfcDialogState extends State<WriteNfcDialog> {
  bool _isWriting = false;
  bool _isWritten = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isWritten ? 'NFC tag written' : 'Write to NFC Card'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_isWritten
              ? 'You can now remove your NFC card.'
              : 'Please hold your NFC card near the device.'),
          SizedBox(height: 16),
          if (_isWriting)
            CircularProgressIndicator()
          else if (_isWritten)
            Icon(Icons.check_circle, color: Colors.green, size: 48),
        ],
      ),
      actions: [
        if (!_isWritten)
          TextButton(
            onPressed: _isWriting ? null : _writeToNfc,
            child: Text('Write'),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(_isWritten ? 'OK' : 'Cancel'),
        ),
      ],
    );
  }

  Future<void> _writeToNfc() async {
    setState(() {
      _isWriting = true;
    });

    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {
            Ndef? ndef = Ndef.from(tag);
            if (ndef != null) {
              await ndef.write(NdefMessage([
                NdefRecord.createText(widget.encryptedUid),
                NdefRecord.createText(widget.time.toString())
              ]));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('NFC tag written')),
              );
              setState(() {
                _isWriting = false;
                _isWritten = true;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to write NFC tag')),
              );
              setState(() {
                _isWriting = false;
              });
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to write NFC tag: ${e.toString()}')),
            );
            setState(() {
              _isWriting = false;
            });
          } finally {
            await NfcManager.instance.stopSession();
          }
        },
      );
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to write NFC tag: ${e.message}')),
      );
      setState(() {
        _isWriting = false;
      });
    }
  }
}
