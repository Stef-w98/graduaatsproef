import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:graduaatsproef/services/database/database_service.dart';

class CheckInOutUtils {
  static Future<String> checkInOut(String uid) async {
    final hashedUid = sha512256.convert(utf8.encode(uid)).toString();
    final userId =
        await DatabaseService().nfcCardsService.lookupNfcCard(hashedUid);

    if (userId == null) {
      throw Exception('UID not found in the database.');
    }

    final userData = await DatabaseService().usersService.getUserData(userId);

    if (userData == null) {
      throw Exception('User not found in the database.');
    }

    final isCheckedIn = userData['checked_in'];
    final isNowCheckedIn = !isCheckedIn;

    await DatabaseService().usersService.updateUser(
          id: int.parse(userId),
          checkedIn: isNowCheckedIn,
        );

    final timestamp = DateTime.now();

    if (isCheckedIn) {
      final lastAttendance =
          await DatabaseService().attendanceService.getLastAttendance(userId);
      if (lastAttendance != null) {
        await DatabaseService().attendanceService.updateAttendance(
              id: lastAttendance.id,
              userId: int.parse(userId),
              checkOutTime: timestamp,
            );
      }
      return 'Goodbye ${userData['first_name']}';
    } else {
      await DatabaseService().attendanceService.addAttendance(
            userId: int.parse(userId),
            checkInTime: timestamp,
            date: timestamp,
          );
      return 'Welcome ${userData['first_name']}';
    }
  }
}
