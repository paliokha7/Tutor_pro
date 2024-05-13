import 'package:flutter/material.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/home/presentation/screens/home_page.dart';
import 'package:tutor_pro/theme/pallete.dart';

class ScoreScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Pallete.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              'Вітаю!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Ви відповіли на $correctAnswers з $totalQuestions правильних',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Button(
              function: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false,
                );
              },
              text: 'Домашня Сторінка',
            ),
          ],
        ),
      ),
    );
  }
}
