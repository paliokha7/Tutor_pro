import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tutor_pro/features/history/presentation/cubits/history_cubit/history_cubit.dart';
import 'package:tutor_pro/features/history/presentation/screens/reading_history.dart';
import 'package:tutor_pro/features/history/repository/model/history_model.dart';

import 'package:tutor_pro/theme/pallete.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    _historyCubit = context.read<HistoryCubit>();
    _getUserData();
  }

  void _getUserData() {
    _historyCubit.fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія'),
        centerTitle: false,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HistoryLoaded) {
            return _buildHistoryList(state.historyList);
          } else if (state is HistoryError) {
            return Center(
                child: Text(
              'Помилка: ${state.error} ',
              style: const TextStyle(color: Pallete.white),
            ));
          } else {
            return const Center(
              child: Text(
                'Невідомий стан!',
                style: TextStyle(color: Pallete.white),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryList(List<ParaphraseModel> paraphrases) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final paraphrase = paraphrases[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12, right: 16, left: 16),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Pallete.white,
                  title: Text(
                    paraphrase.topic,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            paraphrase.subject.isNotEmpty
                                ? '${paraphrase.subject[0].toUpperCase()}${paraphrase.subject.substring(1)}'
                                : '',
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat('dd.MM.yyyy').format(paraphrase.createdAt),
                          style: const TextStyle(
                              fontSize: 12, color: Pallete.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HistoryReading(
                          paraphrase: paraphrase,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: paraphrases.length,
          ),
        ),
      ],
    );
  }
}
