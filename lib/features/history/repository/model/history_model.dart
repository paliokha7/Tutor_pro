import 'package:tutor_pro/features/quiz/repository/model/quiiz_model.dart';

class ParaphraseModel {
  final int id;
  final String subject;
  final String topic;
  final String paraphrase;
  final DateTime createdAt;
  final List<Question> questions;

  ParaphraseModel({
    required this.id,
    required this.subject,
    required this.topic,
    required this.paraphrase,
    required this.createdAt,
    required this.questions,
  });

  factory ParaphraseModel.fromJson(Map<String, dynamic> json) {
    return ParaphraseModel(
      id: json['id'],
      subject: json['subject'],
      topic: json['topic'],
      paraphrase: json['paraphrase'],
      createdAt: DateTime.parse(json['created_at']),
      questions: json['questions'],
    );
  }
}
