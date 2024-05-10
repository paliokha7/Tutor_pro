import 'package:dio/dio.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';

class AuthRepository {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  AuthRepository();

  Future<UserModel> register({
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
          'password_confirmation': '12345678',
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
      await tokenManeger.saveAccessToken(token);

      return user;
    } catch (e) {
      throw Failure('Failed to register: $e');
    }
  }

  Future<UserModel> login({
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
      await tokenManeger.saveAccessToken(token);

      return user;
    } catch (e) {
      throw Failure('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    try {
      final token = await tokenManeger.getAccessToken();

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
      await tokenManeger.removeAccessToken();
    } catch (e) {
      throw Failure('Failed to logout: $e');
    }
  }
}
