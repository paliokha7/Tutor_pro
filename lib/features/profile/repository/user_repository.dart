import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/type_defs.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';

class UserRepository {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  UserRepository();

  FutureEither<UserModel> getUserData() async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.get(
        ApiConstans.getUserData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final userData = response.data['data']['user'];
        final user = UserModel.fromJson(userData);

        return right(user);
      } else {
        return left(Failure('Failed to get user data: ${response.statusCode}'));
      }
    } catch (e) {
      return left(Failure('Failed to get user data: $e'));
    }
  }
}
