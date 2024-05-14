import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_pro/features/auth/%20repository/auth_service_impl.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  void signIn(String email, String password, BuildContext context) async {
    emit(AuthLoading());
    final result =
        await _authRepository.login(email: email, password: password);

    result.fold(
      (failure) {
        if (failure.message == '422') {
          emit(AuthInvalidInput());
        } else {
          emit(AuthError(error: failure.toString()));
        }
      },
      (user) {
        emit(AuthAuthenticated(user: user));
        emit(LogIn());
      },
    );
  }

  void signUp(String userName, String email, String password) async {
    emit(AuthLoading());
    final result = await _authRepository.register(
        userName: userName, email: email, password: password);
    result.fold(
      (failure) {
        if (failure.message == '422') {
          emit(AuthInvalidInput());
        } else {
          emit(AuthError(error: failure.toString()));
        }
      },
      (user) {
        emit(AuthAuthenticated(user: user));
        emit(LogIn());
      },
    );
  }

  void logOut() async {
    try {
      await _authRepository.logout();
      emit(LogOut());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
