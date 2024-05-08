import 'package:equatable/equatable.dart';
import 'package:tutor_pro/core/type_defs.dart';

abstract class Usecase<Type, Params> {
  FutureEither<Type> call(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
