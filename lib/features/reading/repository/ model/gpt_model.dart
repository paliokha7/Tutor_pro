class GptModel {
  final int id;
  final String paraphrase;
  GptModel({
    required this.id,
    required this.paraphrase,
  });

  factory GptModel.fromJson(Map<String, dynamic> json) {
    return GptModel(
      id: json['id'],
      paraphrase: json['paraphrase'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paraphrase': paraphrase,
    };
  }
}
