import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/entities/user.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/type_defs.dart';
import 'package:tutor_pro/features/auth/data/datasources/auth_service.dart';
import 'package:tutor_pro/features/auth/data/model/user_model.dart';
import 'package:tutor_pro/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl(this.authService);

  FutureEither<User> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authService.register(
        userName: userName,
        email: email,
        password: password,
      );
      final user = _convertUserModelToUser(userModel);
      return right(user);
    } catch (e) {
      print('$e');

      return left(Failure('Failed to register: $e'));
    }
  }

  @override
  FutureEither<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authService.login(
        email: email,
        password: password,
      );
      final user = _convertUserModelToUser(userModel);
      return right(user);
    } catch (e) {
      print('$e');
      return left(Failure('Failed to login: $e'));
    }
  }

  User _convertUserModelToUser(UserModel userModel) {
    return User(
      id: userModel.id,
      accessToken: userModel.accessToken,
      userName: userModel.userName,
      email: userModel.email,
    );
  }

  @override
  Future<Either<Failure, void>> logout({required String token}) async {
    try {
      await authService.logout();
      return right(unit);
    } catch (e) {
      return left(Failure('Failed to logout: $e'));
    }
  }
}
