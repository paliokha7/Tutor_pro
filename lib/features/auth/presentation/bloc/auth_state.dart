part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final String? token; // Додаємо поле для токену

  const AuthState({this.token});

  @override
  List<Object?> get props => [token];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user, {String? token}) : super(token: token);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
