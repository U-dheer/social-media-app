import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:social_app/features/auth/data/repository/MockAuthRepository.dart';
import 'package:social_app/features/auth/data/repository/datasources/session_local_data_source.dart';
import 'package:social_app/features/auth/domain/services/user_session_service.dart';
import 'package:social_app/features/auth/domain/usercases/login_use_case.dart';
import 'package:social_app/features/auth/domain/usercases/register_use_case.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:social_app/features/auth/presentation/login/screens/login_page.dart';
import 'package:social_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:social_app/features/auth/presentation/register/screens/register_page.dart';
import 'package:social_app/features/feed/data/repository/mock_posts_repository.dart';
import 'package:social_app/features/feed/domain/usecases/create_post_use_case.dart';
import 'package:social_app/features/feed/domain/usecases/fetch_post_use_case.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:social_app/features/feed/presentation/screens/feed_page.dart';
import 'package:social_app/features/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final SessionLocalDataSource sessionLocalDataSource =
        SessionLocalDataSourceImpl(secureStorage: secureStorage);
    final UserSessionService userSessionService = UserSessionService(
      sessionLocalDataSource: sessionLocalDataSource,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(
              authRepository: Mockauthrepository(),
            ),
            userSessionService: userSessionService,
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(authRepository: Mockauthrepository()),
            userSessionService: userSessionService,
          ),
        ),

        BlocProvider(
          create: (_) => FeedBloc(
            fetchPostsUseCase: FetchPostsUseCase(
              postRepository: MockPostRepository(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => CreatePostBloc(
            createPostUseCase: CreatePostUseCase(
              postRepository: MockPostRepository(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Register Page',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashPage(userSessionService: userSessionService),
        // initialRoute: '/login',
        routes: {
          '/register': (_) => const RegisterPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const FeedPage(),
        },
      ),
    );
  }
}
