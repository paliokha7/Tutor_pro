import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/entities/user.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/usecases/usecase.dart';
import 'package:tutor_pro/features/auth/domain/repository/auth_repository.dart';

class RegisterUser extends Usecase<User, RegisterUserParams> {
  final AuthRepository authRepository;

  RegisterUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(RegisterUserParams param) async {
    return await authRepository.register(
      userName: param.userName,
      email: param.email,
      password: param.password,
    );
  }
}

class RegisterUserParams extends Equatable {
  final String userName;
  final String email;
  final String password;

  const RegisterUserParams({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [userName, email, password];
}
