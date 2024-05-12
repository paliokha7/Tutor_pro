import 'package:flutter/material.dart';
import 'package:tutor_pro/core/constans/subject_constans.dart';
import 'package:tutor_pro/features/home/presentation/screens/widgets/pop_up.dart';
import 'package:tutor_pro/features/home/presentation/screens/widgets/subject.dart';
import 'package:tutor_pro/theme/pallete.dart';

class Subjects extends StatelessWidget {
  const Subjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('List of Subjects'),
            centerTitle: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.lightBlue,
                    title: 'Literature',
                    subtitle: 'Read the story and take the test',
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const PopUp(
                            subject: SubjectKey.literature,
                          );
                        });
                  },
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.lightOrage,
                    title: 'Geography',
                    subtitle: 'Read the summary and take the test',
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const PopUp(
                            subject: SubjectKey.geography,
                          );
                        });
                  },
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.lightRed,
                    title: 'History',
                    subtitle: 'Read the summary and take the test',
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const PopUp(
                            subject: SubjectKey.history,
                          );
                        });
                  },
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.green,
                    title: 'Biology',
                    subtitle: 'Read the summary and take the test',
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const PopUp(
                            subject: SubjectKey.biology,
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
