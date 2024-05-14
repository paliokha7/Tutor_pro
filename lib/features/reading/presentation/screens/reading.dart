import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/reading/presentation/cubit/gpt_cubit.dart';
import 'package:tutor_pro/features/profile/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:tutor_pro/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:tutor_pro/features/quiz/presentation/quiz_page.dart';
import 'package:tutor_pro/theme/pallete.dart';

class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _getUserData();
  }

  void _getUserData() {
    _userCubit.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GptCubit, GptState>(
      builder: (context, state) {
        if (state is GptLoaded) {
          final paraphrase = state.gpt.paraphrase;
          final paraphraseId = state.gpt.id;

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Читання'),
                  centerTitle: false,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          paraphrase,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Button(
                          text: 'Пройти тест',
                          function: () {
                            _getUserData();
                            final userCubit = context.read<UserCubit>();
                            if (userCubit.isPremiumUser()) {
                              context
                                  .read<QuizCubit>()
                                  .fetchQuestions(paraphraseId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QuizPage(
                                    paraphraseId: paraphraseId,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Для проходження тесту потрібен преміум-доступ.',
                                    style: TextStyle(
                                        color: Pallete.lightBackground),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is GptError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.error}'),
            ),
          );
        } else {
          return const Scaffold(
            body: Align(
              alignment: Alignment.center,
              child: SpinKitWanderingCubes(
                color: Pallete.lightPurple,
                size: 50.0,
              ),
            ),
          );
        }
      },
    );
  }
}
