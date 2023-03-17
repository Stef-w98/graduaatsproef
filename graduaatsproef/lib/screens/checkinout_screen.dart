import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
              onPressed: () async {
                try {
                  // Start session
                  await NfcManager.instance.startSession(
                    onDiscovered: (NfcTag tag) async {
                      NdefMessage? message = await Ndef.from(tag)?.read();
                      if (message != null) {
                        String response = String.fromCharCodes(message.records
                            .expand((record) => record.payload)
                            .toList());
                        print('NFC card read: $response');
                      }
                      await NfcManager.instance.stopSession();
                    },
                  );
                } on Exception catch (e) {
                  print('Error reading NFC card: $e');
                }
              },
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(Icons.nfc),
              iconSize: 72,
              onPressed: () async {
                String messageToWrite = 'Hello NFC tag!';
                try {
                  await NfcManager.instance.startSession(
                    onDiscovered: (NfcTag tag) async {
                      Ndef? ndef = Ndef.from(tag);
                      if (ndef != null) {
                        await ndef.write(NdefMessage([
                          NdefRecord.createText(messageToWrite),
                        ]));
                        print('NFC tag written: $messageToWrite');
                      }
                      await NfcManager.instance.stopSession();
                    },
                  );
                } on Exception catch (e) {
                  print('Error writing NFC tag: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
