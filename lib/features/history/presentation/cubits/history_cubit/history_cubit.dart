import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tutor_pro/features/history/repository/history_repository.dart';
import 'package:tutor_pro/features/history/repository/model/history_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _historyRepository;

  HistoryCubit({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository,
        super(HistoryInitial());

  void fetchHistory() async {
    emit(const HistoryLoading());
    final result = await _historyRepository.fetchHistory();
    result.fold(
      (error) => emit(HistoryError('Failed to fetch history: $error')),
      (paraphrases) => emit(HistoryLoaded(paraphrases)),
    );
  }
}
