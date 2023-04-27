import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/services/database/database_tables/encryption_service.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../utils/decryption_util.dart';
import '../utils/encryption_util.dart';

class CheckInOutScreen extends StatelessWidget {
  CheckInOutScreen({Key? key}) : super(key: key);
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F24),
      appBar: AppBar(
        title: const Text('Check In/Out'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap your NFC card to check in/out',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(
                Icons.nfc,
                color: Colors.white,
              ),
              iconSize: 72,
              onPressed: () async {
                try {
                  await NfcManager.instance.startSession(
                    onDiscovered: (NfcTag tag) async {
                      NdefMessage? message = await Ndef.from(tag)?.read();
                      if (message != null) {
                        String encryptedUid =
                            String.fromCharCodes(message.records[0].payload);
                        String dateTimeString =
                            String.fromCharCodes(message.records[1].payload);

                        // Remove unwanted characters from payload strings
                        encryptedUid = encryptedUid.replaceAll(',', '');
                        encryptedUid =
                            encryptedUid.substring(4, encryptedUid.length - 1);
                        dateTimeString = dateTimeString.substring(3);

                        String decryptedUid = await decryptUid(
                          encryptedUid,
                          dateTimeString,
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('NFC Card Read'),
                              content: Text(
                                'The UID on this card is: $decryptedUid\n'
                                'The date and time when the card was written was: $dateTimeString',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      await NfcManager.instance.stopSession();
                    },
                  );
                } on PlatformException catch (e) {
                  print('Error reading NFC card: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
