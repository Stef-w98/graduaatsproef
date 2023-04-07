import 'package:graduaatsproef/models/attendance_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService {
  final supabase = Supabase.instance.client;

  Future<List<Attendance>> getAttendance() async {
    final response = await supabase.from('attendance').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    final List<dynamic> data = response.data ?? [];
    if (data.isEmpty) {
      return [];
    }
    final List<Attendance> attendance =
        data.map((json) => Attendance.fromJson(json)).toList();
    attendance.forEach((a) => print('${a.id}: ${a.userId} - ${a.checkInTime}'));
    return attendance;
  }

  Future<int> addAttendance({
    required int userId,
    required DateTime checkInTime,
    required DateTime date,
  }) async {
    final response = await supabase.from('attendance').insert({
      'user_id': userId,
      'check_in_time': checkInTime.toIso8601String(),
      'date': date.toIso8601String(),
    }).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return response.data!.first['attendance_id'];
  }

  Future<void> updateAttendance({
    required int id,
    required int userId,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    DateTime? date,
  }) async {
    final updates = <String, dynamic>{};
    if (userId != null) {
      updates['user_id'] = userId;
    }
    if (checkInTime != null) {
      updates['check_in_time'] = checkInTime.toIso8601String();
    }
    if (checkOutTime != null) {
      updates['check_out_time'] = checkOutTime.toIso8601String();
    }
    if (date != null) {
      updates['date'] = date.toIso8601String();
    }
    final response = await supabase
        .from('attendance')
        .update(updates)
        .eq('attendance_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<void> deleteAttendance(int id) async {
    final response = await supabase
        .from('attendance')
        .delete()
        .eq('attendance_id', id)
        .execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }
}
