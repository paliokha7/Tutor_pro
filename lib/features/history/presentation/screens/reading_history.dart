import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/history/presentation/screens/quiz_history.dart';
import 'package:tutor_pro/features/history/repository/model/history_model.dart';
import 'package:tutor_pro/features/profile/presentation/cubits/user_cubit/user_cubit.dart';

class HistoryReading extends StatefulWidget {
  final ParaphraseModel paraphrase;

  const HistoryReading({super.key, required this.paraphrase});

  @override
  State<HistoryReading> createState() => _HistoryReadingState();
}

class _HistoryReadingState extends State<HistoryReading> {
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Reading'),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: [
                  Text(
                    widget.paraphrase.paraphrase,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.paraphrase.questions.isNotEmpty)
                    Button(
                      text: 'Пройти тест',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPageHistory(
                                questions: widget.paraphrase.questions),
                          ),
                        );
                      },
                    ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
