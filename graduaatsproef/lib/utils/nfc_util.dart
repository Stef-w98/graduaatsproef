import 'dart:typed_data';
import 'dart:math';
import 'encryption_util.dart';

String generateUID(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final rnd = Random.secure();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}

Map<String, Uint8List> generateAndEncryptUID(int length, Uint8List key) {
  String uid = generateUID(length);
  Map<String, Uint8List> encryptedDataAndIV = Encrypt(uid, key);
  return encryptedDataAndIV;
}
