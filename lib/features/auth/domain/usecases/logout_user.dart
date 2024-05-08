import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/usecases/usecase.dart';
import 'package:tutor_pro/features/auth/domain/repository/auth_repository.dart';

class LogoutUser implements Usecase<void, LogoutUserParams> {
  final AuthRepository authRepository;

  LogoutUser(this.authRepository);

  @override
  Future<Either<Failure, void>> call(LogoutUserParams params) async {
    try {
      await authRepository.logout(token: params.token);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to logout: $e'));
    }
  }
}

class LogoutUserParams {
  final String token;

  LogoutUserParams({required this.token});
}
