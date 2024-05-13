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
        title: const Text('Quiz'),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoaded) {
            final totalQuestions = state.questions.length;

            final currentQuestionIndex =
                context.read<QuizCubit>().currentQuestionIndex;
            final currentQuestion = state.questions[currentQuestionIndex];

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            totalQuestions,
                            (index) => indicatorWidget(
                                index, currentQuestionIndex, context),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${currentQuestionIndex + 1} / $totalQuestions',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
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
                                  side: const BorderSide(
                                      color: Pallete.black, width: 1),
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
                                      selectedOptionIndex: index,
                                      context: context);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is QuizLoading) {
            return const Center(
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

  Widget indicatorWidget(
      int questionIndex, int currentQuestionIndex, BuildContext context) {
    final color = questionIndex <= currentQuestionIndex
        ? Pallete.lightPurple
        : Colors.grey;
    final widthIndicator = MediaQuery.of(context).size.width * 0.15;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: widthIndicator,
        height: 6,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
