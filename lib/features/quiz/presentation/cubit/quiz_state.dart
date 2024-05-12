part of 'quiz_cubit.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

final class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;

  const QuizLoaded({
    required this.questions,
    required this.currentQuestionIndex,
  });

  @override
  List<Object> get props => [
        questions,
        currentQuestionIndex,
      ]; // Add these parameters to the props list
}

class QuizError extends QuizState {
  final String errorMessage;

  QuizError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
