import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/domain/services/user_session_service.dart';
import 'package:social_app/features/auth/domain/usercases/login_use_case.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_event.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  UserSessionService userSessionService;

  LoginBloc({required this.loginUseCase, required this.userSessionService})
    : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, emit) async {
    emit(LoginLoading());
    try {
      final token = await loginUseCase.call(
        email: event.email,
        password: event.password,
      );
      await userSessionService.presistSession(token: token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}
