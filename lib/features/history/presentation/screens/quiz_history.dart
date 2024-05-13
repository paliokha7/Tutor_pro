import 'package:flutter/material.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/home/presentation/screens/home_page.dart';
import 'package:tutor_pro/features/quiz/repository/model/quiiz_model.dart';
import 'package:tutor_pro/theme/pallete.dart';

class QuizPageHistory extends StatefulWidget {
  final List<Question> questions;

  const QuizPageHistory({super.key, required this.questions});

  @override
  State<QuizPageHistory> createState() => _QuizPageHistoryState();
}

class _QuizPageHistoryState extends State<QuizPageHistory> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
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
                'Ви відповіли на $correctAnswers з ${widget.questions.length} правильних',
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
                text: 'Домашня сторінка',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkAnswer(int optionIndex) {
    if (widget.questions[currentQuestionIndex].options[optionIndex].isCorrect) {
      correctAnswers++;
    }
    goToNextQuestion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                      widget.questions.length,
                      (index) =>
                          indicatorWidget(index, currentQuestionIndex, context),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${currentQuestionIndex + 1}/5',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                ' ${widget.questions[currentQuestionIndex].question}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              for (var i = 0;
                  i < widget.questions[currentQuestionIndex].options.length;
                  i++) ...[
                ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.white,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      widget.questions[currentQuestionIndex].options[i].option,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {
                    checkAnswer(i);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
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
