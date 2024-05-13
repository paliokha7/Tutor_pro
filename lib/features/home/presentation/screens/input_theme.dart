import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/core/common/sign_button.dart';
import 'package:tutor_pro/features/reading/presentation/cubit/gpt_cubit.dart';
import 'package:tutor_pro/features/reading/presentation/screens/reading.dart';
import 'package:tutor_pro/theme/pallete.dart';

class InputTheme extends StatefulWidget {
  final String subject;
  final bool showRadioButtons;

  const InputTheme({
    super.key,
    required this.subject,
    this.showRadioButtons = false,
  });

  @override
  State<InputTheme> createState() => _InputThemeState();
}

class _InputThemeState extends State<InputTheme> {
  final TextEditingController topicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String summaryType = 'Short';

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тема запиту'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: topicController,
                decoration: const InputDecoration(
                  hintText: 'Введіть тему',
                ),
                maxLines: null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Введіть тему';
                  }
                  return null;
                },
              ),
              if (widget.showRadioButtons) ...[
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (widget.showRadioButtons) _showSummaryTypePopup();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Pallete.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Тип переказу: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          summaryType == 'short' ? 'Стислий' : 'Розгорнутий',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Pallete.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Button(
                function: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<GptCubit>().clearData();
                    final String topic = topicController.text;
                    context
                        .read<GptCubit>()
                        .fetchData(widget.subject, summaryType, topic);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Reading()),
                    );
                  }
                },
                text: 'Отримати',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSummaryTypePopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: const Text(
                      'Стислий',
                      style: TextStyle(fontSize: 16),
                    ),
                    value: 'short',
                    groupValue: summaryType,
                    onChanged: (value) {
                      setState(() {
                        summaryType = value as String;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'Розгорнутий',
                      style: TextStyle(fontSize: 16),
                    ),
                    value: 'long',
                    groupValue: summaryType,
                    onChanged: (value) async {
                      setState(() {
                        summaryType = value as String;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    ).then((_) {
      setState(() {});
    });
  }
}
