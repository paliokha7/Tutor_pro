import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tutor_pro/features/quiz/presentation/scrore_screen.dart';
import 'package:tutor_pro/features/quiz/repository/model/quiiz_model.dart';
import 'package:tutor_pro/features/quiz/repository/quiz_repository.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository _quizRepository;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  QuizCubit({required QuizRepository quizRepository})
      : _quizRepository = quizRepository,
        super(QuizInitial());

  void fetchQuestions(int id) async {
    emit(QuizLoading());
    final eitherQuestions =
        await _quizRepository.fetchtestParaphrase(parapharaseId: id);
    eitherQuestions.fold(
      (failure) => emit(QuizError('Failed to fetch questions: $failure')),
      (questions) => emit(QuizLoaded(
        questions: questions,
        currentQuestionIndex: currentQuestionIndex,
      )),
    );
  }

  void getNextQuestion(
      {required int selectedOptionIndex, required BuildContext context}) {
    final currentState = state;

    if (currentState is QuizLoaded) {
      final currentQuestions = currentState.questions;

      if (currentQuestionIndex < currentQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Reached the last question
        // Navigate to the score screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScoreScreen(
              correctAnswers: correctAnswers,
              totalQuestions: currentQuestions.length,
            ),
          ),
        );
      }

      final selectedOption =
          currentQuestions[currentQuestionIndex].options[selectedOptionIndex];

      if (selectedOption.isCorrect) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }

      emit(QuizLoaded(
        questions: currentQuestions,
        currentQuestionIndex: currentQuestionIndex,
      ));
    }
  }
}
