import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/profile/presentation/cubits/payment_cubit/payment_cubit.dart';

class BottomSheetPayment extends StatefulWidget {
  const BottomSheetPayment({super.key});

  @override
  State<BottomSheetPayment> createState() => _BottomSheetPaymentState();
}

class _BottomSheetPaymentState extends State<BottomSheetPayment> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expireController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    expireController.dispose();
    cardNumberController.dispose();
    cardHolderController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentCubit = context.read<PaymentCubit>();

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Введіть ваші дані',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            CreditCardForm(
              cardNumber: cardNumberController.text,
              expiryDate: expireController.text,
              cardHolderName: cardHolderController.text,
              cvvCode: cvvController.text,
              formKey: formKey,
              inputConfiguration: const InputConfiguration(
                cvvCodeDecoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: 'XXX',
                  counterText: '',
                ),
              ),
              onCreditCardModelChange: (CreditCardModel data) {
                setState(() {
                  String cardNumberWithoutSpaces =
                      data.cardNumber.replaceAll(' ', '');
                  cardNumberController.text = cardNumberWithoutSpaces;
                  expireController.text = data.expiryDate;
                  cardHolderController.text = data.cardHolderName;
                  cvvController.text = data.cvvCode;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),
              child: Button(
                text: 'Купити',
                function: () {
                  if (cardNumberController.text.isEmpty ||
                      expireController.text.isEmpty ||
                      cvvController.text.isEmpty) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Будь ласка, заповніть всі поля'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    final cardNumber1 = cardNumberController.text;
                    final expireDate = expireController.text;
                    final cvv = cvvController.text;

                    paymentCubit.payment(cardNumber1, expireDate, cvv);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Оплата пройшла успішно'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
