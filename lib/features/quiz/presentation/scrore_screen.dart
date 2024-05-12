import 'package:flutter/material.dart';
import 'package:tutor_pro/features/home/presentation/screens/home_page.dart';

class ScoreScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScoreScreen(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $correctAnswers out of $totalQuestions questions correctly.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
              },
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
