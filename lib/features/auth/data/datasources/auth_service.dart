import 'package:tutor_pro/features/auth/data/model/user_model.dart';

abstract class AuthService {
  Future<UserModel> register({
    required String userName,
    required String email,
    required String password,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}
