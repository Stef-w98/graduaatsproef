import 'dart:convert';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class EncryptionService {
  final supabase = Supabase.instance.client;

  Future<int> addEncryptionKey({
    required Uint8List key,
    required Uint8List iv,
    required DateTime createdAt,
  }) async {
    final encodedKey = base64.encode(key);
    final response = await supabase.from('encryption_key').insert({
      'key': encodedKey,
      'iv': base64.encode(iv),
      'created_at': createdAt.toIso8601String(),
    }).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    return response.data!.first['encryption_id'];
  }

  Future<EncryptionKey> getEncryptionKey(String createTime) async {
    final response = await supabase
        .from('encryption_key')
        .select()
        .eq('created_at', createTime)
        .limit(1)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final data = response.data!.first;
    final key = base64.decode(data['key']);
    final iv = base64.decode(data['iv']);
    return EncryptionKey(
      id: data['encryption_id'],
      key: key,
      iv: iv,
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  Future<void> updateEncryptionKey({
    required int id,
    required Uint8List key,
    required Uint8List iv,
  }) async {
    final response = await supabase
        .from('encryption')
        .update({'key': base64.encode(key), 'iv': base64.encode(iv)})
        .eq('encryption_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteEncryptionKey(int id) async {
    final response = await supabase
        .from('encryption')
        .delete()
        .eq('encryption_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}

class EncryptionKey {
  final int id;
  final Uint8List key;
  final Uint8List iv;
  final DateTime createdAt;

  EncryptionKey({
    required this.id,
    required this.key,
    required this.iv,
    required this.createdAt,
  });

  factory EncryptionKey.fromJson(Map<String, dynamic> json) {
    return EncryptionKey(
      id: json['encryption_id'],
      key: base64.decode(json['key']),
      iv: base64.decode(json['iv']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
