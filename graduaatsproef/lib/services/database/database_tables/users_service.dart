import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:graduaatsproef/models/users_model.dart' as UsersModel;
import 'package:graduaatsproef/utils/decryption_util.dart';
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
    final encryptionKey = generateRandomBytes(32);
    final iv = EncryptionUtil.generateIV();

    final encryptedAddress =
        EncryptionUtil.encrypt(address, encryptionKey, iv)['encryptedData'];
    final encryptedCity =
        EncryptionUtil.encrypt(city, encryptionKey, iv)['encryptedData'];
    final encryptedZipCode =
        EncryptionUtil.encrypt(zipcode, encryptionKey, iv)['encryptedData'];
    final encryptedCountry =
        EncryptionUtil.encrypt(country, encryptionKey, iv)['encryptedData'];
    final encryptedPhone =
        EncryptionUtil.encrypt(phone, encryptionKey, iv)['encryptedData'];

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
    final user = await getUserById(id.toString());
    if (user == null) {
      throw Exception('User not found');
    }

    final createdAt = DateTime.parse(user['created_at']);
    final encryptionKey =
        await encryptionService.getEncryptionKey(createdAt.toString());

    if (encryptionKey == null) {
      throw Exception('Encryption key not found');
    }

    final iv = encryptionKey.iv;
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
      final encryptedAddress = EncryptionUtil.encrypt(
          address, encryptionKey.key, iv)['encryptedData'];
      updates['address'] = encryptedAddress;
    }
    if (city != null) {
      final encryptedCity =
          EncryptionUtil.encrypt(city, encryptionKey.key, iv)['encryptedData'];
      updates['city'] = encryptedCity;
    }
    if (zipcode != null) {
      final encryptedZipCode = EncryptionUtil.encrypt(
          zipcode, encryptionKey.key, iv)['encryptedData'];
      updates['zip_code'] = encryptedZipCode;
    }
    if (country != null) {
      final encryptedCountry = EncryptionUtil.encrypt(
          country, encryptionKey.key, iv)['encryptedData'];
      updates['country'] = encryptedCountry;
    }
    if (phone != null) {
      final encryptedPhone =
          EncryptionUtil.encrypt(phone, encryptionKey.key, iv)['encryptedData'];
      updates['phone'] = encryptedPhone;
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

  /*Future<int> updateUser({
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
  }*/

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
      final userData = user![0] as Map<String, dynamic>;

      final createTime = userData['created_at'] as String;
      final encryptionKey =
          await encryptionService.getEncryptionKey(createTime);
      if (encryptionKey != null) {
        final decryptedData = <String, dynamic>{};
        userData.forEach((key, value) {
          if (key == 'address' ||
              key == 'city' ||
              key == 'zip_code' ||
              key == 'country' ||
              key == 'phone') {
            print('Value: ${value.toString()}');
            final encryptedValue = value.toString();
            final sanitizedValue =
                encryptedValue.replaceAll(RegExp(r'[^\d,]'), '');
            final dataList = sanitizedValue.split(',');
            final dataIntList = dataList.map(int.parse).toList();
            final encryptedBytes = Uint8List.fromList(dataIntList);
            final decryptedValue = decryptData(
                encryptedBytes, encryptionKey.key, encryptionKey.iv);
            decryptedData[key] = utf8.decode(decryptedValue);
          } else {
            decryptedData[key] = value;
          }
        });
        return decryptedData;
      }
    }
    return null;
  }
}
