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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FlutterSecureStorage _secureStorage;
  late final SessionLocalDataSource _sessionLocalDataSource;
  late final UserSessionService _userSessionService;
  late final Mockauthrepository _authRepository;
  late final MockPostRepository _postRepository;

  @override
  void initState() {
    super.initState();
    _initializeDependencies();
  }

  void _initializeDependencies() {
    _secureStorage = const FlutterSecureStorage();
    _sessionLocalDataSource = SessionLocalDataSourceImpl(
      secureStorage: _secureStorage,
    );
    _userSessionService = UserSessionService(
      sessionLocalDataSource: _sessionLocalDataSource,
    );
    _authRepository = Mockauthrepository();
    _postRepository = MockPostRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(authRepository: _authRepository),
            userSessionService: _userSessionService,
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(authRepository: _authRepository),
            userSessionService: _userSessionService,
          ),
        ),
        BlocProvider(
          create: (_) => FeedBloc(
            fetchPostsUseCase: FetchPostsUseCase(
              postRepository: _postRepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => CreatePostBloc(
            createPostUseCase: CreatePostUseCase(
              postRepository: _postRepository,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Register Page',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashPage(userSessionService: _userSessionService),
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
