import 'package:social_app/features/auth/domain/entities/user_entity.dart';
import 'package:social_app/features/auth/domain/models/loginParams.dart';
import 'package:social_app/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<String> register({required UserEntity user}) async {
    return "token";
  }

  @override
  Future<String> login({required Loginparams loginParams}) async {
    return "token";
  }
}

class MockAuthWithErrorRepository implements AuthRepository {
  @override
  Future<String> register({required UserEntity user}) async {
    throw Exception("Registration failed");
  }

  @override
  Future<String> login({required Loginparams loginParams}) async {
    throw Exception("Login failed");
  }
}
