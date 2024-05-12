part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

class PaymentSucces extends PaymentState {
  final UserModel user;

  const PaymentSucces({required this.user});
}

class PaymentError extends PaymentState {
  final String error;

  const PaymentError({required this.error});

  @override
  List<Object> get props => [error];
}

class PaymentAlready extends PaymentState {}
