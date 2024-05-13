import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tutor_pro/features/quiz/presentation/scrore_screen.dart';
import 'package:tutor_pro/features/quiz/repository/model/quiiz_model.dart';
import 'package:tutor_pro/features/quiz/repository/quiz_repository.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository _quizRepository;
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  int correctAnswers = 0;

  QuizCubit({required QuizRepository quizRepository})
      : _quizRepository = quizRepository,
        super(QuizInitial());

  void fetchQuestions(int id) async {
    emit(QuizLoading());
    final eitherQuestions =
        await _quizRepository.fetchtestParaphrase(parapharaseId: id);
    eitherQuestions.fold(
        (failure) => emit(QuizError('Failed to fetch questions: $failure')),
        (questions) {
      this.questions = questions;
      currentQuestionIndex = 0;
      correctAnswers = 0;
      emit(QuizLoaded(
        questions: questions,
        currentQuestionIndex: currentQuestionIndex,
      ));
    });
  }

  void getNextQuestion(
      {required int selectedOptionIndex, required BuildContext context}) {
    final currentState = state;

    if (currentState is QuizLoaded) {
      final currentQuestion = currentState.questions[currentQuestionIndex];

      final selectedOption = currentQuestion.options[selectedOptionIndex];

      if (selectedOption.isCorrect) {
        correctAnswers++;
      }

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        emit(QuizLoaded(
          questions: questions,
          currentQuestionIndex: currentQuestionIndex,
        ));
      } else {
        showDialog(
          context: context,
          builder: (_) => ScoreScreen(
            correctAnswers: correctAnswers,
            totalQuestions: questions.length,
          ),
        );
      }
    }
  }
}
