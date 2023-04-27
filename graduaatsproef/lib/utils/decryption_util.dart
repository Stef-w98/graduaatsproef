import 'dart:convert';
import 'dart:typed_data';

import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/export.dart';

Future<String> decryptUid(String encryptedUid, String createdAtString) async {
  final encryptionKey = await DatabaseService()
      .encryptionService
      .getEncryptionKey(createdAtString);

  final key = encryptionKey.key;
  final iv = encryptionKey.iv;

  final params = PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESFastEngine()));
  cipher.init(false, params);

  final encryptedBytes = utf8.encode(encryptedUid);
  final decryptedBytes = cipher.process(Uint8List.fromList(encryptedBytes));

  final decryptedUid = utf8.decode(decryptedBytes);

  return decryptedUid;
}

Uint8List decodeBase64(String base64String) {
  return base64.decode(base64String);
}
