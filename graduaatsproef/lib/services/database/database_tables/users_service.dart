import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:graduaatsproef/models/users_model.dart' as UsersModel;
import 'package:graduaatsproef/utils/encryption_util.dart' as EncryptionUtil;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'encryption_service.dart';

class UsersService {
  final supabase = Supabase.instance.client;
  final encryptionService = EncryptionService();

  Future<List<UsersModel.Users>> getUsers() async {
    final response = await supabase.from('users').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final userMaps = List<Map<String, dynamic>>.from(response.data!);
    final users =
        userMaps.map((map) => UsersModel.Users.fromJson(map)).toList();
    users.forEach((user) => print(
        '${user.id}: ${user.firstName} ${user.lastName} - ${user.email} - ${user.checkedIn}'));
    return users;
  }

  Future<int> addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String city,
    required String zipcode,
    required String country,
    required String phone,
    required bool checkedIn,
  }) async {
    final createdAt = DateTime.now();
    final encryptionKey =
        generateRandomBytes(32); // Generate a random 32-byte key
    final encryptedAddress =
        EncryptionUtil.encrypt(address, encryptionKey)['encryptedData'];
    final encryptedCity =
        EncryptionUtil.encrypt(city, encryptionKey)['encryptedData'];
    final encryptedZipCode =
        EncryptionUtil.encrypt(zipcode, encryptionKey)['encryptedData'];
    final encryptedCountry =
        EncryptionUtil.encrypt(country, encryptionKey)['encryptedData'];
    final encryptedPhone =
        EncryptionUtil.encrypt(phone, encryptionKey)['encryptedData'];

    final response = await supabase.from('users').insert({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'address': encryptedAddress,
      'city': encryptedCity,
      'zip_code': encryptedZipCode,
      'country': encryptedCountry,
      'phone': encryptedPhone,
      'checked_in': checkedIn,
      'created_at': createdAt.toString(),
    }).execute();

    if (response.error != null) {
      throw Exception(response.error!.message);
    }

    final userId = response.data!.first['user_id'];
    final iv = EncryptionUtil.generateIV();

    await encryptionService.addEncryptionKey(
      key: encryptionKey,
      iv: iv,
      createdAt: createdAt,
    );

    return userId;
  }

  Uint8List generateRandomBytes(int length) {
    final _random = Random.secure();
    return Uint8List.fromList(
        List<int>.generate(length, (_) => _random.nextInt(256)));
  }

/*Future<int> addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String city,
    required String zipcode,
    required String country,
    required String phone,
    required bool checkedIn,
  }) async {
    final response = await supabase.from('users').insert({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'address': address,
      'city': city,
      'zip_code': zipcode,
      'country': country,
      'phone': phone,
      'checked_in': checkedIn,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.data!.first['user_id'];
  }*/

  Future<int> updateUser({
    required int id,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? city,
    String? zipcode,
    String? country,
    String? phone,
    bool? checkedIn,
  }) async {
    final updates = <String, dynamic>{};
    if (firstName != null) {
      updates['first_name'] = firstName;
    }
    if (lastName != null) {
      updates['last_name'] = lastName;
    }
    if (email != null) {
      updates['email'] = email;
    }
    if (address != null) {
      updates['address'] = address;
    }
    if (city != null) {
      updates['city'] = city;
    }
    if (zipcode != null) {
      updates['zip_code'] = zipcode;
    }
    if (country != null) {
      updates['country'] = country;
    }
    if (phone != null) {
      updates['phone'] = phone;
    }
    if (checkedIn != null) {
      updates['checked_in'] = checkedIn;
    }
    final response = await supabase
        .from('users')
        .update(updates)
        .eq('user_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.data!.length;
  }

  Future<void> deleteUser(int id) async {
    final response =
        await supabase.from('users').delete().eq('user_id', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final response = await supabase
        .from('users')
        .select('user_id, first_name, last_name, email, checked_in')
        .eq('user_id', userId)
        .single()
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final data = response.data as Map<String, dynamic>?;
    return data;
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    final response =
        await supabase.from('users').select().eq('user_id', userId).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final user = response.data as List<dynamic>?;
    if (user?.length == 1) {
      return user![0] as Map<String, dynamic>?;
    }
    return null;
  }
}
