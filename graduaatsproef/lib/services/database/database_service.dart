import 'database_tables/users_service.dart';
import 'database_tables/nfc_cards_service.dart';
import 'database_tables/attendance_service.dart';

class DatabaseService {
  final UsersService usersService = UsersService();
  final NfcCardsService nfcCardsService = NfcCardsService();
  final AttendanceService attendanceService = AttendanceService();
}
