import 'dart:convert';
import 'dart:typed_data';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

Future<Uint8List> decryptUid(Uint8List encryptedUid, String time) async {
  final encryptionKey =
      await DatabaseService().encryptionService.getEncryptionKey(time);

  final key = encryptionKey.key;
  final iv = encryptionKey.iv;

  final params = PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
  cipher.init(true, params);

  final decryptedBytes = cipher.process(encryptedUid);

  return decryptedBytes;
}

Uint8List decodeBase64(String base64String) {
  return base64.decode(base64String);
}
