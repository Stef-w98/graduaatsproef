import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

Uint8List decryptData(Uint8List encryptedText, Uint8List key, Uint8List iv) {
  print('DecrypionText: ${encryptedText.toString()}');
  print('DecrypionKey: ${key.toString()}');
  print('DecrypionIV: ${iv.toString()}');
  final params = PaddedBlockCipherParameters(
    ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
    null,
  );
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
  cipher.init(false, params);

  final decryptedBytes = cipher.process(encryptedText);
  return decryptedBytes;
}

String encodeBase64(Uint8List data) {
  return base64.encode(data);
}

Uint8List decodeBase64(String base64String) {
  return base64.decode(base64String);
}

/*import 'dart:convert';
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
  cipher.init(false, params);

  final decryptedBytes = cipher.process(encryptedUid);
  print('decrypt decryptedBytes: ' '$decryptedBytes');
  print('to string: ' '${utf8.decode(decryptedBytes)}');
  return decryptedBytes;
}

Uint8List decodeBase64(String base64String) {
  return base64.decode(base64String);
}*/
