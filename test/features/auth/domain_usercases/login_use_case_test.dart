import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/auth/domain/usercases/login_use_case.dart';
import 'package:social_app/features/auth/data/repository/MockAuthRepository.dart';

void main() {
  group('LoginUseCase test', () {
    late LoginUseCase loginUseCase;

    setUp(() {
      loginUseCase = LoginUseCase(authRepository: Mockauthrepository());
    });

    test('Should login user sucessfully and return token', () async {
      final String email = 'fabrico@gmail.com';
      final String password = '1234';

      final result = await loginUseCase.call(email: email, password: password);
      expect(result, 'token');
    });

    test('Should return and error with empty email', () async {
      final String email = 'fabrico';
      final String password = '1234';

      expect(
        () async => await loginUseCase.call(email: email, password: password),
        throwsA(isA<Exception>()),
      );
    });
  });
}
