import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/home/repository/%20model/gpt_model.dart';
import 'package:tutor_pro/features/home/repository/gpt_repository.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  final GptRepository _gptRepository;

  GptCubit({required GptRepository gptRepository})
      : _gptRepository = gptRepository,
        super(GptInitial());

  Future<void> fetchData(String subjectKey, String topic) async {
    try {
      switch (subjectKey) {
        case 'literature':
          final data = await _gptRepository.fetchLiteratureParaphrase(
            topic: topic,
          );
          emit(GptLoaded(gpt: data));
          break;
        case 'географія':
          final data = await _gptRepository.fetchSubjectsParaphrase(
              topic: topic, subject: subjectKey);
          emit(GptLoaded(gpt: data));
          break;
        case 'історія':
          final data = await _gptRepository.fetchSubjectsParaphrase(
              topic: topic, subject: subjectKey);
          emit(GptLoaded(gpt: data));
          break;
        case 'біологія':
          final data = await _gptRepository.fetchSubjectsParaphrase(
              topic: topic, subject: subjectKey);
          emit(GptLoaded(gpt: data));
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
