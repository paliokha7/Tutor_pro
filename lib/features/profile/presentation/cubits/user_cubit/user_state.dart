part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;

  const UserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String error;

  const UserError({required this.error});

  @override
  List<Object> get props => [error];
}

class UserNotPremium extends UserState {
  final UserModel user;

  const UserNotPremium({required this.user});

  @override
  List<Object> get props => [user];
}
