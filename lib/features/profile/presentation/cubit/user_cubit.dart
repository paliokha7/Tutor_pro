import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/features/auth/%20repository/model/user_model.dart';
import 'package:tutor_pro/features/profile/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial());

  void getUserData() async {
    try {
      final user = await _userRepository.getUserData();
      emit(UserSuccess(user: user));
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }
}
