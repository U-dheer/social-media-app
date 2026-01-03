import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/auth/domain/usercases/login_use_case.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_event.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_state.dart';

import '../../data/repository/MockAuthRepository.dart';

void main() {
  group('LoginBloc test', () {
    late LoginBloc loginBloc;
    late LoginBloc loginBlockWithRepositoryError;

    setUp(() {
      loginBloc = LoginBloc(
        loginUseCase: LoginUseCase(authRepository: MockAuthRepository()),
      );
      loginBlockWithRepositoryError = LoginBloc(
        loginUseCase: LoginUseCase(
          authRepository: MockAuthWithErrorRepository(),
        ),
      );
    });

    blocTest(
      'emit [LoginLoading, LoginSucess] when login is Sucessful',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginSubmitted(email: 'fabrico@gmail.com', password: '1234'),
      ),
      expect: () => [LoginLoading(), LoginSuccess()],
    );

    blocTest(
      'emit [LoginLoading, LoginFailure] when password is incorrect',
      build: () => loginBlockWithRepositoryError,
      act: (bloc) => bloc.add(
        LoginSubmitted(email: 'fabrico@gmail.com', password: '123432'),
      ),
      expect: () => [LoginLoading(), isA<LoginFailure>()],
    );

    blocTest(
      'emit [LoginLoading, LoginFailure] when repository throws exception',
      build: () => loginBlockWithRepositoryError,
      act: (bloc) => bloc.add(
        LoginSubmitted(email: 'fabrico@gmail.com', password: '1234'),
      ),
      expect: () => [LoginLoading(), isA<LoginFailure>()],
    );
  });
}
