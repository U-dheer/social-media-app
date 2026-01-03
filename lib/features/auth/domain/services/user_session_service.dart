import 'package:social_app/features/auth/data/repository/datasources/session_local_data_source.dart';

class UserSessionService {
  final SessionLocalDataSource sessionLocalDataSource;
  UserSessionService({required this.sessionLocalDataSource});

  Future<void> saveUserSession({required String token}) async {
    return await sessionLocalDataSource.saveToken(token: token);
  }

  Future<String> getUserSession() {
    return sessionLocalDataSource.getToken();
  }

  Future<void> clearUserSession() {
    return sessionLocalDataSource.deleteToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await sessionLocalDataSource.getToken();
    return token.isNotEmpty;
  }
}
