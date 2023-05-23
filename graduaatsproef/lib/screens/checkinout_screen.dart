import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduaatsproef/utils/checkin_util.dart';
import 'package:graduaatsproef/widgets/drawer_widget.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:hex/hex.dart';

class CheckInOutScreen extends StatelessWidget {
  CheckInOutScreen({Key? key}) : super(key: key);
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
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
              onPressed: () => readNfcCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> readNfcCard(BuildContext context) async {
    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          NfcA? nfcA = NfcA.from(tag);
          Uint8List? uid = nfcA?.identifier;

          String uidHexString = HEX.encode(uid!);
          print(uidHexString);
          String checkinout = await CheckInOutUtils.checkInOut(uidHexString);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Checkpoint'),
                content: Text(checkinout),
                actions: <Widget>[
                  FloatingActionButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          await NfcManager.instance.stopSession();
        },
      );
    } on PlatformException catch (e) {
      print('Error reading NFC card: $e');
    }
  }
}
