import 'package:social_app/features/auth/data/repository/datasources/session_local_data_source.dart';
import 'package:social_app/features/auth/domain/services/user_session_service.dart';

class MockUserSessionService implements UserSessionService {
  @override
  Future<String> getUserSession() async {
    return 'mock_token';
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> presistSession({required String token}) async {}

  @override
  // TODO: implement sessionLocalDataSource
  SessionLocalDataSource get sessionLocalDataSource =>
      throw UnimplementedError();
}
