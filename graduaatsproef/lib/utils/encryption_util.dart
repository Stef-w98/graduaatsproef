import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/export.dart';

Uint8List generateRandomBytes(int length) {
  final _random = Random.secure();
  return Uint8List.fromList(
      List<int>.generate(length, (_) => _random.nextInt(256)));
}

Uint8List generateIV() {
  final rnd = Random.secure();
  final bytes = Uint8List(16);
  for (int i = 0; i < 16; i++) {
    bytes[i] = rnd.nextInt(256);
  }
  return bytes;
}

Uint8List encryptAES256(String plainText, Uint8List key, Uint8List iv) {
  final params = PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESFastEngine()));
  cipher.init(true, params);

  final inputBytes = Uint8List.fromList(utf8.encode(plainText));
  final encryptedBytes = cipher.process(inputBytes);
  return encryptedBytes;
}

Map<String, Uint8List> Encrypt(String plainText, Uint8List key) {
  final iv = generateIV();
  final encryptedBytes = encryptAES256(plainText, key, iv);
  return {'encryptedData': encryptedBytes, 'iv': iv};
}
