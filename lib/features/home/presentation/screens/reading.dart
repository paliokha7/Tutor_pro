import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/home/presentation/cubit/gpt_cubit.dart';
import 'package:tutor_pro/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:tutor_pro/features/quiz/presentation/quiz_page.dart';

class Reading extends StatelessWidget {
  const Reading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Reading'),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<GptCubit, GptState>(
              builder: (context, state) {
                if (state is GptLoaded) {
                  final paraphrase = state.gpt.paraphrase;
                  final paraphraseId = state.gpt.id;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          paraphrase,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Button(
                            text: 'Пройти тест',
                            function: () {
                              context
                                  .read<QuizCubit>()
                                  .fetchQuestions(paraphraseId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => QuizPage(
                                            paraphraseId: paraphraseId,
                                          )));
                            })
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
