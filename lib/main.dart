import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/auth/%20repository/auth_service_impl.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tutor_pro/features/history/presentation/cubits/history_cubit/history_cubit.dart';
import 'package:tutor_pro/features/history/repository/history_repository.dart';
import 'package:tutor_pro/features/reading/presentation/cubit/gpt_cubit.dart';
import 'package:tutor_pro/features/home/presentation/screens/home_page.dart';
import 'package:tutor_pro/features/reading/repository/gpt_repository.dart';
import 'package:tutor_pro/features/profile/presentation/cubits/payment_cubit/payment_cubit.dart';
import 'package:tutor_pro/features/profile/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:tutor_pro/features/profile/repository/payment_repository.dart';
import 'package:tutor_pro/features/profile/repository/user_repository.dart';
import 'package:tutor_pro/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:tutor_pro/features/quiz/repository/quiz_repository.dart';
import 'package:tutor_pro/theme/cubit/theme_cubit.dart';
import 'package:tutor_pro/theme/pallete.dart';

import 'features/auth/presentation/screens/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository: AuthRepository()),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(userRepository: UserRepository()),
        ),
        BlocProvider<GptCubit>(
          create: (context) => GptCubit(gptRepository: GptRepository()),
        ),
        BlocProvider<PaymentCubit>(
          create: (context) =>
              PaymentCubit(paymentRepository: PaymentRepository()),
        ),
        BlocProvider<QuizCubit>(
          create: (context) => QuizCubit(quizRepository: QuizRepository()),
        ),
        BlocProvider<HistoryCubit>(
          create: (context) =>
              HistoryCubit(historyRepository: HistoryRepository()),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeMode == ThemeMode.light
                ? AppTheme.lightTheme
                : AppTheme.dartTheme,
            home: FutureBuilder<String?>(
              future: TokenManeger().getAccessToken(),
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
          );
        },
      ),
    );
  }
}
