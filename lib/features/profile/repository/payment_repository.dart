import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/type_defs.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';

class PaymentRepository {
  Dio dio = Dio();
  TokenManeger tokenManager = TokenManeger();

  PaymentRepository();

  FutureEither<UserModel> premiumPayment({
    required String cardNumber,
    required String expireDate,
    required String cvv,
  }) async {
    try {
      final token = await tokenManager.getAccessToken();
      final response = await dio.post(
        ApiConstans.premiumPayment,
        data: {
          "card": cardNumber,
          "cvv": cvv,
          "date_of_expiration": expireDate
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      final userData = response.data['data']['user'];

      final user = UserModel.fromJson(userData);

      return right(user);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return left(Failure('422'));
      } else {
        return left(Failure('Failed to register: ${e.message}'));
      }
    }
  }
}
