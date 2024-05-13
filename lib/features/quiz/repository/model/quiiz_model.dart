class Question {
  int id;
  String question;
  int paraphraseId;
  List<Option> options;

  Question({
    required this.id,
    required this.question,
    required this.paraphraseId,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final List<dynamic> optionsJson = json['options'];
    final List<Option> options =
        optionsJson.map((optionJson) => Option.fromJson(optionJson)).toList();

    return Question(
      id: json['id'],
      question: json['question'],
      paraphraseId: json['paraphrase_id'],
      options: options,
    );
  }
}

class Option {
  int id;
  String option;
  bool isCorrect;

  Option({
    required this.id,
    required this.option,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      option: json['option'],
      isCorrect: json['correct'] == 1 ? true : false,
    );
  }
}
