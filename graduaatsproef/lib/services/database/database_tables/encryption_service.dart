import 'dart:convert';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class EncryptionService {
  final supabase = Supabase.instance.client;

  Future<int> addEncryptionKey({
    required int userId,
    required Uint8List key,
    required Uint8List iv,
    required DateTime createdAt,
  }) async {
    final response = await supabase.from('encryption').insert({
      'user_id': userId,
      'key': base64.encode(key),
      'iv': base64.encode(iv),
      'created_at': createdAt.toIso8601String(),
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.data!.first['encryption_id'];
  }

  Future<EncryptionKey> getEncryptionKey(int userId) async {
    final response = await supabase
        .from('encryption')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
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
      userId: data['user_id'],
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
  final int userId;
  final Uint8List key;
  final Uint8List iv;
  final DateTime createdAt;

  EncryptionKey({
    required this.id,
    required this.userId,
    required this.key,
    required this.iv,
    required this.createdAt,
  });

  factory EncryptionKey.fromJson(Map<String, dynamic> json) {
    return EncryptionKey(
      id: json['encryption_id'],
      userId: json['user_id'],
      key: base64.decode(json['key']),
      iv: base64.decode(json['iv']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
