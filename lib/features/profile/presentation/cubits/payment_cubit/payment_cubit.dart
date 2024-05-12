import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';
import 'package:tutor_pro/features/profile/repository/payment_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository;
  PaymentCubit({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(PaymentInitial());

  void payment(String cardNumber, String expireDate, String cvv) async {
    final result = await _paymentRepository.premiumPayment(
        cardNumber: cardNumber, expireDate: expireDate, cvv: cvv);
    result.fold(
      (failure) {
        if (failure.message == '422') {
          emit(PaymentAlready());
        } else {
          emit(PaymentError(error: failure.toString()));
        }
      },
      (user) {
        emit(PaymentSucces(user: user));
      },
    );
  }
}
