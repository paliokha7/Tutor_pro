part of 'gpt_cubit.dart';

sealed class GptState extends Equatable {
  const GptState();

  @override
  List<Object> get props => [];
}

final class GptInitial extends GptState {}

class GptLoaded extends GptState {
  final GptModel gpt;

  const GptLoaded({required this.gpt});

  @override
  List<Object> get props => [gpt];
}

class GptError extends GptState {
  final Failure error;

  const GptError({required this.error});

  @override
  List<Object> get props => [error];
}
