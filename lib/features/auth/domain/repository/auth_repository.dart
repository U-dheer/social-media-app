import 'package:social_app/features/auth/domain/entities/user_entity.dart';
import 'package:social_app/features/auth/domain/models/loginParams.dart';

abstract class AuthRepository {
  Future<String> register({required UserEntity user});
  Future<String> login({required Loginparams loginParams});
}
