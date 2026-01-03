import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/auth/domain/usercases/register_use_case.dart';
import 'package:social_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:social_app/features/auth/presentation/register/bloc/register_event.dart';
import 'package:social_app/features/auth/presentation/register/bloc/register_state.dart';

import '../../data/repository/MockAuthRepository.dart';

void main() {
  group('Registerbloc test', () {
    late RegisterBloc registerBloc;
    late RegisterBloc registerBlocWithRepositoryError;

    setUp(() {
      registerBloc = RegisterBloc(
        registerUseCase: RegisterUseCase(authRepository: MockAuthRepository()),
      );
      registerBlocWithRepositoryError = RegisterBloc(
        registerUseCase: RegisterUseCase(
          authRepository: MockAuthWithErrorRepository(),
        ),
      );
    });
    blocTest(
      'emit [RegisterLoading, RegisterSuccess] when register is sucessful',
      build: () => registerBloc,
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: "fabrico@gmail.com",
          username: "fabrico",
          password: "1234",
        ),
      ),
      expect: () => [RegisterLoading(), RegisterSuccess()],
    );

    blocTest(
      'emit [RegisterLoading, RegisterFailure] when email is unsuccessful',
      build: () => registerBloc,
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: "fabrico",
          username: "fabrico",
          password: "1234",
        ),
      ),
      expect: () => [RegisterLoading(), isA<RegisterFailure>()],
    );

    blocTest(
      'emit [RegisterLoading, RegisterFailure] when repository throws error',
      build: () => registerBlocWithRepositoryError,
      act: (bloc) => bloc.add(
        RegisterSubmitted(
          email: "fabrico@gmail.com",
          username: "fabrico",
          password: "1234",
        ),
      ),
      expect: () => [RegisterLoading(), isA<RegisterFailure>()],
    );
  });
}
