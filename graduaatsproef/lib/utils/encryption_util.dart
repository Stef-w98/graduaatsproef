import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

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
  print('ENCRYPTION: ');
  print('Plaintext: $plainText');
  print('Key: $key');
  print('Iv: $iv');
  final params = PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
  cipher.init(true, params);

  final inputBytes = Uint8List.fromList(utf8.encode(plainText));
  final encryptedBytes = cipher.process(inputBytes);
  print('Encrypted Bytes: $encryptedBytes');
  return encryptedBytes;
}

Map<String, Uint8List> encrypt(String plainText, Uint8List key) {
  final iv = generateIV();
  print(iv);
  print(key);
  final encryptedBytes = encryptAES256(plainText, key, iv);
  return {'encryptedData': encryptedBytes, 'iv': iv};
}

/*import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/pointycastle.dart';

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
  print('ENCRYPTION: ');
  print('Plaintext: ' '$plainText');
  print('Key: ' '$key');
  print('Iv: ' '$iv');
  final params = PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv), null);
  final cipher =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
  cipher.init(true, params);

  final inputBytes = Uint8List.fromList(utf8.encode(plainText));
  final encryptedBytes = cipher.process(inputBytes);
  print('encryptedBytes: ' '$encryptedBytes');
  return encryptedBytes;
}

Map<String, Uint8List> encrypt(String plainText, Uint8List key) {
  final iv = generateIV();
  print(iv);
  print(key);
  final encryptedBytes = encryptAES256(plainText, key, iv);
  return {'encryptedData': encryptedBytes, 'key': key, 'iv': iv};
}*/
