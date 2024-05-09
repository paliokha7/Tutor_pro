import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/core/entities/user.dart';
import 'package:tutor_pro/features/auth/data/datasources/local/token_manager.dart';

import 'package:tutor_pro/features/auth/domain/usecases/login_user.dart';
import 'package:tutor_pro/features/auth/domain/usecases/logout_user.dart';
import 'package:tutor_pro/features/auth/domain/usecases/register_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  TokenManeger tokenManeger = TokenManeger();

  AuthBloc({
    required this.registerUser,
    required this.loginUser,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final eitherUser = await registerUser(RegisterUserParams(
      userName: event.userName,
      email: event.email,
      password: event.password,
    ));

    eitherUser.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) async {
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final eitherUser = await loginUser(LoginUserParams(
      email: event.email,
      password: event.password,
    ));

    eitherUser.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    if (state is AuthSuccess) {
      final userToken = (state as AuthSuccess).token;
      if (userToken != null) {
        final eitherUnit = await logoutUser(LogoutUserParams(token: userToken));

        eitherUnit.fold(
          (failure) => emit(AuthError(failure.message)),
          (_) {
            tokenManeger.removeAccessToken(); // Видалення токену
            emit(AuthInitial()); // Перехід в AuthInitial після виходу
          },
        );
      } else {
        print('Failed');
      }
    }
  }
}
