import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/entities/user.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/usecases/usecase.dart';
import 'package:tutor_pro/features/auth/domain/repository/auth_repository.dart';

class LoginUser extends Usecase<User, LoginUserParams> {
  final AuthRepository authRepository;
  LoginUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LoginUserParams param) async {
    return await authRepository.login(
      email: param.email,
      password: param.password,
    );
  }
}

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
