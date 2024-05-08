import 'package:tutor_pro/core/entities/user.dart';
import 'package:tutor_pro/core/type_defs.dart';

abstract class AuthRepository {
  FutureEither<User> register(
      {required String userName,
      required String email,
      required String password});
  FutureEither<User> login({required String email, required String password});
  Future<void> logout({required String token});
}
