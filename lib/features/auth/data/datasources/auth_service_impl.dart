import 'package:dio/dio.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/auth/data/datasources/local/token_manager.dart';
import 'package:tutor_pro/features/auth/data/datasources/auth_service.dart';
import 'package:tutor_pro/features/auth/data/model/user_model.dart';

class AuthServiceImpl implements AuthService {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  AuthServiceImpl(this.dio);

  @override
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
      await tokenManeger.saveAccessToken(token);
      print(token);

      return user;
    } catch (e) {
      throw Failure('Failed to register: $e');
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstans.login,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      final responseData = response.data;
      final userData = responseData['data']['user']['token'];

      final user = UserModel.fromJson(userData);
      await tokenManeger.saveAccessToken(userData);
      print(userData);

      return user;
    } catch (e) {
      throw Failure('Failed to login: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Отримати токен з SharedPreferences
      final token = await tokenManeger.getAccessToken();

      await dio.delete(
        ApiConstans.loginOut,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }, // Додати токен у заголовки
        ),
      );
    } catch (e) {
      throw Failure('Failed to logout: $e');
    }
  }
}
