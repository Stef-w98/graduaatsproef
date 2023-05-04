import 'package:flutter_test/flutter_test.dart';
import 'package:graduaatsproef/services/database/database_service.dart';

void main() {
  group('getUserData', () {
    test('returns user data for valid user ID', () async {
      // Arrange
      final userId = 'valid_user_id_here';

      // Act
      final userData = await DatabaseService().usersService.getUserData(userId);

      // Assert
      expect(userData, isNotNull);
      expect(userData!['user_id'], userId);
      // Add more expectations based on the response from your Supabase query.
    });

    test('throws exception for invalid user ID', () async {
      // Arrange
      final invalidUserId = 'invalid_user_id_here';

      // Act & Assert
      expect(() => DatabaseService().usersService.getUserData(invalidUserId),
          throwsException);
    });
  });
}
