import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:hex/hex.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class WriteNfcDialog extends StatefulWidget {
  final int userId;

  WriteNfcDialog({required this.userId});

  @override
  _WriteNfcDialogState createState() => _WriteNfcDialogState();
}

class _WriteNfcDialogState extends State<WriteNfcDialog> {
  bool _isWriting = false;
  bool _isWritten = false;
  bool _isError = false;
  String? uid = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isWritten ? 'NFC tag written' : 'Write to NFC Card'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_isWritten
              ? 'You can now remove your NFC card.'
              : _isError
                  ? 'Failed to write NFC tag. Please try again.'
                  : 'Please hold your NFC card near the device.'),
          SizedBox(height: 16),
          if (_isWriting)
            CircularProgressIndicator()
          else if (_isWritten)
            Icon(Icons.check_circle, color: Colors.green, size: 48)
          else
            Icon(Icons.error_outline, color: Colors.red, size: 48),
        ],
      ),
      actions: [
        if (!_isWritten && !_isError)
          TextButton(
            onPressed: _isWriting ? null : _writeToNfc,
            child: Text(_isWriting ? 'Writing...' : 'Write',
                style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          ),
        if (_isError)
          TextButton(
            onPressed: _isWriting ? null : _retryWriteToNfc,
            child: Text(_isWriting ? 'Retrying...' : 'Try Again',
                style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(_isWritten ? 'OK' : 'Cancel',
              style: TextStyle(color: Colors.white)),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
      ],
    );
  }

  Future<void> _writeToNfc() async {
    setState(() {
      _isWriting = true;
      _isError = false;
    });

    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {
            NfcA? nfcA = NfcA.from(tag);
            if (nfcA != null) {
              uid = await readNfcCard();
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
                _isError = true;
              });
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Failed to write NFC tag: ${e.toString()}')),
            );
            setState(() {
              _isWriting = false;
              _isError = true;
            });
          } finally {
            nfcCardToDatabase();
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
        _isError = true;
      });
    }
  }

  Future<void> _retryWriteToNfc() async {
    setState(() {
      _isWriting = true;
      _isWritten = false;
      _isError = false;
    });
    await _writeToNfc();
  }

  Future<String> readNfcCard() async {
    final completer = Completer<String>();
    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          NfcA? nfcA = NfcA.from(tag);
          Uint8List? uid = nfcA?.identifier;
          String uidHexString = HEX.encode(uid!);

          await NfcManager.instance.stopSession();
          completer.complete(uidHexString);
        },
      );
    } on PlatformException catch (e) {
      print('Error reading uid on NFC card: $e');
    }
    return completer.future;
  }

  Future<void> nfcCardToDatabase() async {
    final hashedUid = sha512256.convert(utf8.encode(uid!)).toString();

    await DatabaseService()
        .nfcCardsService
        .addCard(userId: widget.userId, cardUid: hashedUid);
  }
}
