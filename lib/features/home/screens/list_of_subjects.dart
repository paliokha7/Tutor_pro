import 'package:flutter/material.dart';
import 'package:tutor_pro/features/home/screens/widgets/subject.dart';
import 'package:tutor_pro/theme/pallete.dart';

class Subjects extends StatelessWidget {
  const Subjects({Key? key});

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
                const SubjectCard(
                  color: Pallete.lightBlue,
                  title: 'Literature',
                  subtitle: 'Read the story and take the test',
                ),
                const SubjectCard(
                  color: Pallete.lightOrage,
                  title: 'Geography',
                  subtitle: 'Read the summary and take the test',
                ),
                const SubjectCard(
                  color: Pallete.lightRed,
                  title: 'History',
                  subtitle: 'Read the summary and take the test',
                ),
                const SubjectCard(
                  color: Pallete.green,
                  title: 'Biologic',
                  subtitle: 'Read the summary and take the test',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
