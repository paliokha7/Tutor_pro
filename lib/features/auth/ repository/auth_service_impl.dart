import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

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

      final responseData = response.data;
      final userData = responseData['data']['user'];
      final token = responseData['data']['token'];

      final user = UserModel.fromJson(userData);
      await tokenManeger.saveUserData(userData);
      await tokenManeger.saveAccessToken(token);
      print(user);

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
      final responseData = response.data;
      final userData = responseData['data']['user'];
      final token = responseData['data']['token'];

      final user = UserModel.fromJson(userData);
      await tokenManeger.saveAccessToken(token);
      print(token);

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
      await tokenManeger.removeAccessToken(); // Видалення токену після виходу
      print('Token after logout: ${await tokenManeger.getAccessToken()}');
      print('Logout successful'); // Доданий вивід
    } catch (e) {
      throw Failure('Failed to logout: $e');
    }
  }
}
