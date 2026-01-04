import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/auth/domain/usercases/register_use_case.dart';

import '../../data/repository/MockAuthRepository.dart';

void main() {
  group("RegistrationUseCase test", () {
    late RegisterUseCase registerUseCase;
    late RegisterUseCase registerUseCaseWithError;
    setUp(() {
      registerUseCase = RegisterUseCase(authRepository: MockAuthRepository());
      registerUseCaseWithError = RegisterUseCase(
        authRepository: MockAuthWithErrorRepository(),
      );
    });

    test('Should register user successfully and return token', () async {
      final String email = "facric@test.com";
      final String username = "fabricio";
      final String password = "securePassword123";

      final result = await registerUseCase.call(
        email: email,
        username: username,
        password: password,
      );

      expect(result, 'token');
    });

    test('Should return error for empty email', () {
      final String email = "";
      final String username = "fabricio";
      final String password = "securePassword123";

      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should return error if email have Wrong format', () {
      final String email = "fabricio";
      final String username = "fabricio";
      final String password = "securePassword123";

      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should return error if password is too short', () {
      final String email = "fabricio@test.com";
      final String username = "fabricio";
      final String password = "123";

      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should return error if username is empty', () {
      final String email = "fabricio@test.com";
      final String username = "";
      final String password = "123";

      expect(
        () async => await registerUseCase.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should return error if username is empty', () {
      final String email = "fabricio@test.com";
      final String username = "fabricio";
      final String password = "1234";

      expect(
        () async => await registerUseCaseWithError.call(
          email: email,
          username: username,
          password: password,
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
