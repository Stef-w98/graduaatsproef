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
          CheckInOutUtils.checkInOut(uidHexString);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('UID'),
                content: Text(uidHexString),
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

// Future<void> readNfcCard(BuildContext context) async {
  //   try {
  //     await NfcManager.instance.startSession(
  //       onDiscovered: (NfcTag tag) async {
  //         String uidh = tag.handle;
  //         var uiddata = tag.data;
  //         print(uidh);
  //         NdefMessage? message = await Ndef.from(tag)?.read();
  //         if (message != null) {
  //           String encryptedUid =
  //               String.fromCharCodes(message.records[0].payload);
  //           String dateTimeString =
  //               String.fromCharCodes(message.records[1].payload);
  //
  //           dateTimeString = dateTimeString.substring(3);
  //           encryptedUid = encryptedUid.replaceAll(
  //               RegExp(r'[^\d,]'), ''); // remove non-digits and commas
  //           List<String> uidList = encryptedUid.split(",");
  //           List<int> uidIntList = uidList.map(int.parse).toList();
  //           Uint8List bytesuid = Uint8List.fromList(uidIntList);
  //
  //           final decryptedUid = await decryptUid(
  //             bytesuid,
  //             dateTimeString,
  //           );
  //           String test123 = utf8.decode(decryptedUid);
  //           CheckInOutUtils.checkInOut(test123);
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ReadNfcDialog(
  //                 uid: test123,
  //                 dateTimeString: dateTimeString,
  //               ),
  //             ),
  //           );
  //         }
  //         await NfcManager.instance.stopSession();
  //       },
  //     );
  //   } on PlatformException catch (e) {
  //     print('Error reading NFC card: $e');
  //   }
  // }
}
