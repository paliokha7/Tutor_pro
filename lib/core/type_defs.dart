import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
