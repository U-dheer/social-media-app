import 'package:social_app/features/auth/domain/models/loginParams.dart';
import 'package:social_app/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<String> call({required String email, required String password}) async {
    final loginParams = Loginparams(email: email, password: password);
    final token = await authRepository.login(loginParams: loginParams);
    return token;
  }
}
