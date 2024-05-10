import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/features/auth/%20repository/auth_service_impl.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  void signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user =
          await _authRepository.login(email: email, password: password);
      emit(AuthAuthenticated(user: user));
      emit(LogIn()); // Додано подію LogIn після успішної реєстрації
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  void signUp(String userName, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.register(
          userName: userName, email: email, password: password);
      emit(AuthAuthenticated(user: user));
      emit(LogIn());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
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
