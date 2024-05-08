import 'package:dio/dio.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/shared/token_manager.dart';
import 'package:tutor_pro/features/auth/data/datasources/auth_service.dart';
import 'package:tutor_pro/features/auth/data/model/user_model.dart';

class AuthServiceImpl implements AuthService {
  Dio dio = Dio();
  AuthSharedPreferences authSharedPreferences = AuthSharedPreferences();

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
        data: {'username': userName, 'email': email, 'password': password},
      );

      final userData = response.data['user'];
      final user = UserModel.fromJson(userData);

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
      );
      print('hi');
      final userData = response.data['user'];
      final user = UserModel.fromJson(userData);

      final token = response.headers['authorization'] as String?;
      if (token != null) {
        await authSharedPreferences.saveAccessToken(token);
      }

      return user;
    } catch (e) {
      throw Failure('Failed to login: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Отримати токен з SharedPreferences
      final token = await authSharedPreferences.getAccessToken();

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
