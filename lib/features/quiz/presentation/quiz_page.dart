import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:tutor_pro/theme/pallete.dart';

class QuizPage extends StatelessWidget {
  final int paraphraseId;

  const QuizPage({super.key, required this.paraphraseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoaded) {
            final currentQuestionIndex =
                context.read<QuizCubit>().currentQuestionIndex;
            final currentQuestion = state.questions[currentQuestionIndex];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    currentQuestion.question,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      final option = currentQuestion.options[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Pallete.black, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: Pallete.white,
                          title: Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                            ),
                            child: Text(
                              option.option,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onTap: () {
                            context.read<QuizCubit>().getNextQuestion(
                                selectedOptionIndex: index, context: context);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is QuizLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuizError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
