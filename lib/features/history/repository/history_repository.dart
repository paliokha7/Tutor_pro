import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/type_defs.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/history/repository/model/history_model.dart';
import 'package:tutor_pro/features/quiz/repository/model/quiiz_model.dart';

class HistoryRepository {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  HistoryRepository();

  FutureEither<List<ParaphraseModel>> fetchHistory() async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.get(
        ApiConstans.historyData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      final List<dynamic> responseData = response.data['data']['history'];
      List<ParaphraseModel> paraphrases = [];
      for (var questionData in responseData) {
        final List<dynamic> questionsData = questionData['questions'];
        final List<Question> questions = questionsData
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();

        final paraphrase = ParaphraseModel.fromJson({
          ...questionData,
          'questions': questions,
        });
        paraphrases.add(paraphrase);
      }
      print(paraphrases);
      return right(paraphrases);
    } catch (e) {
      return left(Failure('Failed to fetch paraphrases: $e'));
    }
  }
}
