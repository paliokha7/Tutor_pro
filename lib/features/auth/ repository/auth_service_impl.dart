import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/type_defs.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';

class AuthRepository {
  Dio dio = Dio();
  TokenManeger tokenManager = TokenManeger();

  AuthRepository();

  FutureEither<UserModel> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstans.register,
        data: {
          'username': userName,
          'email': email,
          'password': password,
          'device': 'IPhone'
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      final userData = response.data['data']['user'];
      final token = response.data['data']['token'];

      final user = UserModel.fromJson(userData);
      await tokenManager.saveAccessToken(token);

      return right(user);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return left(Failure('422'));
      } else {
        return left(Failure('Failed to register: ${e.message}'));
      }
    }
  }

  FutureEither<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstans.login,
        data: {'email': email, 'password': password, 'device': 'IPhone'},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      final userData = response.data['data']['user'];
      final token = response.data['data']['token'];

      final user = UserModel.fromJson(userData);
      await tokenManager.saveAccessToken(token);
      return right(user);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return left(Failure('422'));
      } else {
        return left(Failure(e.toString()));
      }
    }
  }

  Future<void> logout() async {
    try {
      final token = await tokenManager.getAccessToken();

      await dio.delete(
        ApiConstans.loginOut,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      await tokenManager.removeAccessToken();
    } catch (e) {
      throw Failure('Failed to logout: $e');
    }
  }
}
