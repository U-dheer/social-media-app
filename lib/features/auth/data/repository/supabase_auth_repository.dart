import 'package:social_app/features/auth/domain/entities/user_entity.dart';
import 'package:social_app/features/auth/domain/models/loginParams.dart';
import 'package:social_app/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient client;
  SupabaseAuthRepository({required this.client});

  @override
  Future<String> login({required Loginparams loginParams}) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: loginParams.email,
        password: loginParams.password,
      );
      final session = response.session;
      if (session == null || session.accessToken.isEmpty) {
        throw Exception('Invalid session');
      }
      return session.accessToken;
    } on AuthApiException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Login failed:');
    }
  }

  @override
  Future<String> register({required UserEntity user}) async {
    try {
      final response = await client.auth.signUp(
        email: user.email,
        password: user.password,
        data: {'username': user.username},
      );
      final session = response.session;
      if (session == null || session.accessToken.isEmpty) {
        throw Exception('Invalid session');
      }
      return session.accessToken;
    } on AuthApiException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Registration failed');
    }
  }
}
