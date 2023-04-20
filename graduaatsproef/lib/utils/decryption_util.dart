import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/export.dart';

String decryptAES256(Uint8List encryptedBytes, Uint8List key, Uint8List iv) {
  final params = PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESFastEngine()));
  cipher.init(false, params);

  final decryptedBytes = cipher.process(encryptedBytes);
  return utf8.decode(decryptedBytes);
}

String Decrypt(Uint8List encryptedBytes, Uint8List key, Uint8List iv) {
  return decryptAES256(encryptedBytes, key, iv);
}
