import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/repository/MockAuthRepository.dart';
import 'package:social_app/features/auth/domain/usercases/login_use_case.dart';
import 'package:social_app/features/auth/domain/usercases/register_use_case.dart';
import 'package:social_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:social_app/features/auth/presentation/login/screens/login_page.dart';
import 'package:social_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:social_app/features/auth/presentation/register/screens/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegisterBloc(
            registerUseCase: RegisterUseCase(
              authRepository: Mockauthrepository(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(
            loginUseCase: LoginUseCase(authRepository: Mockauthrepository()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Register Page',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/login',
        routes: {
          '/register': (_) => const RegisterPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Welcome to the Home Page!')));
  }
}
