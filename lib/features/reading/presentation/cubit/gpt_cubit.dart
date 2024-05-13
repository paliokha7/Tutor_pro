import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/reading/repository/%20model/gpt_model.dart';
import 'package:tutor_pro/features/reading/repository/gpt_repository.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  final GptRepository _gptRepository;

  GptCubit({required GptRepository gptRepository})
      : _gptRepository = gptRepository,
        super(GptInitial());

  Future<void> fetchData(String subjectKey, String size, String topic) async {
    try {
      switch (subjectKey) {
        case 'література':
          final literatureData = await _gptRepository.fetchLiteratureParaphrase(
              topic: topic, size: size);
          emit(GptLoaded(gpt: literatureData));
          break;
        case 'географія':
        case 'історія':
        case 'біологія':
          final subjectsData = await _gptRepository.fetchSubjectsParaphrase(
              topic: topic, subject: subjectKey);
          emit(GptLoaded(gpt: subjectsData));
          break;
      }
    } catch (e) {
      emit(GptError(error: Failure('Failed to fetch data: $e')));
    }
  }

  void clearData() {
    emit(GptInitial());
  }
}
