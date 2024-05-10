import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/auth/%20repository/auth_service_impl.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tutor_pro/features/auth/presentation/screens/auth.dart';
import 'package:tutor_pro/features/home/presentation/cubit/gpt_cubit.dart';
import 'package:tutor_pro/features/home/presentation/screens/home_page.dart';
import 'package:tutor_pro/features/home/repository/gpt_repository.dart';
import 'package:tutor_pro/features/profile/presentation/cubit/user_cubit.dart';
import 'package:tutor_pro/features/profile/repository/user_repository.dart';
import 'package:tutor_pro/theme/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthCubit _authCubit;
  late UserCubit _userCubit;
  late GptCubit _gptCubit;

  late TokenManeger _tokenManager;

  @override
  void initState() {
    super.initState();
    _tokenManager = TokenManeger();
    _authCubit = AuthCubit(authRepository: AuthRepository());
    _userCubit = UserCubit(userRepository: UserRepository());
    _gptCubit = GptCubit(gptRepository: GptRepository());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: _authCubit),
        BlocProvider<UserCubit>.value(value: _userCubit),
        BlocProvider<GptCubit>.value(value: _gptCubit),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: FutureBuilder<String?>(
          future: _tokenManager.getAccessToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                return const HomePage();
              } else {
                return const AuthScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
