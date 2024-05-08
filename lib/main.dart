import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/auth/data/datasources/auth_service.dart';
import 'package:tutor_pro/features/auth/data/datasources/auth_service_impl.dart';
import 'package:tutor_pro/features/auth/data/repository/auth_repository.dart';
import 'package:tutor_pro/features/auth/domain/repository/auth_repository.dart';
import 'package:tutor_pro/features/auth/domain/usecases/login_user.dart';
import 'package:tutor_pro/features/auth/domain/usecases/logout_user.dart';
import 'package:tutor_pro/features/auth/domain/usecases/register_user.dart';
import 'package:tutor_pro/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tutor_pro/features/auth/presentation/screens/auth.dart';
import 'package:tutor_pro/features/home/screens/home_page.dart';
import 'package:tutor_pro/theme/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();

    final AuthService authService = AuthServiceImpl(dio);

    final AuthRepository authRepository = AuthRepositoryImpl(authService);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            // Ініціалізуємо AuthBloc з усіма необхідними залежностями
            registerUser: RegisterUser(authRepository),
            loginUser: LoginUser(authRepository),
            logoutUser: LogoutUser(authRepository),
          ),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const AuthScreen(), // Or SignInPage()
        ),
      ),
    );
  }
}
