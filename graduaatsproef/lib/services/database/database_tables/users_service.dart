import 'package:graduaatsproef/models/users_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersService {
  final supabase = Supabase.instance.client;

  Future<List<Users>> getUsers() async {
    final response = await supabase.from('users').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final users = response.data!.map((json) => Users.fromJson(json)).toList();
    users.forEach((user) => print(
        '${user.id}: ${user.firstName} ${user.lastName} - ${user.email}'));
    return users;
  }

  Future<int> addUser({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final response = await supabase.from('users').insert({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.data!.first['user_id'];
  }

  Future<void> updateUser({
    required int id,
    String? firstName,
    String? lastName,
    String? email,
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
    final response = await supabase
        .from('users')
        .update(updates)
        .eq('user_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteUser(int id) async {
    final response =
        await supabase.from('users').delete().eq('user_id', id).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
