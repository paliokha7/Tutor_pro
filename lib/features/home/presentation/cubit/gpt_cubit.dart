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
          final data =
              await _gptRepository.fetchLiteratureParaphrase(topic: topic);
          emit(GptLoaded(gpt: data));
          break;
        case 'geography':
          final data =
              await _gptRepository.fetchGeographyParaphrase(topic: topic);
          emit(GptLoaded(gpt: data));
          break;
        case 'history':
          final data =
              await _gptRepository.fetchHistoryParaphrase(topic: topic);
          emit(GptLoaded(gpt: data));
          break;
        case 'biology':
          final data =
              await _gptRepository.fetchBiologyParaphrase(topic: topic);
          emit(GptLoaded(gpt: data));
          break;
      }
    } catch (e) {
      emit(GptError(error: Failure('Failed to fetch data: $e')));
    }
  }
}
