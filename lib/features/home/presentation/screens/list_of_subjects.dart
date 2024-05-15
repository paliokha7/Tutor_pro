import 'package:flutter/material.dart';
import 'package:tutor_pro/core/constans/subject_constans.dart';
import 'package:tutor_pro/features/home/presentation/screens/input_theme.dart';
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
            title: Text('Список Предметів'),
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
                    title: 'Література',
                    subtitle: 'Прочитайте переказ та пройдіть тест',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InputTheme(
                          subject: SubjectKey.literature,
                          showRadioButtons: true,
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.lightOrage,
                    title: 'Географія',
                    subtitle: 'Прочитайте конспект та пройдіть тест',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const InputTheme(subject: SubjectKey.geography),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.lightRed,
                    title: 'Історія',
                    subtitle: 'Прочитайте конспект та пройдіть тест',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const InputTheme(subject: SubjectKey.history),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: const SubjectCard(
                    color: Pallete.green,
                    title: 'Біологія',
                    subtitle: 'Прочитайте конспект та пройдіть тест',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const InputTheme(subject: SubjectKey.biology),
                      ),
                    );
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
