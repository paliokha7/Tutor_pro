import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_pro/features/home/presentation/cubit/gpt_cubit.dart';

class Reading extends StatelessWidget {
  const Reading({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Reading'),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<GptCubit, GptState>(
              builder: (context, state) {
                if (state is GptLoaded) {
                  final paraphrase = state.gpt.paraphrase;
                  return Text(paraphrase);
                } else if (state is GptError) {
                  return Text('Помилка: ${state.error.message}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
