import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/home/presentation/cubit/gpt_cubit.dart';
import 'package:tutor_pro/features/home/presentation/screens/reading.dart';

class PopUp extends StatefulWidget {
  final String subject;
  const PopUp({super.key, required this.subject});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  final TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input Theme'),
      content: TextField(
        controller: topicController,
        decoration: const InputDecoration(
          hintText: 'Enter topic',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<GptCubit>().clearData();

            final String topic = topicController.text;
            context.read<GptCubit>().fetchData(widget.subject, topic);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Reading()));
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
