part of 'history_cubit.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final List<ParaphraseModel> historyList;

  const HistoryLoaded(this.historyList);
}

class HistoryError extends HistoryState {
  final String error;

  const HistoryError(this.error);
}
