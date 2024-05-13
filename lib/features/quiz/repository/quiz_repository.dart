import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/core/type_defs.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/quiz/repository/model/quiiz_model.dart';

class QuizRepository {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  QuizRepository();

  FutureEither<List<Question>> fetchtestParaphrase(
      {required int parapharaseId}) async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.post(
        '${ApiConstans.test}/$parapharaseId',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['data'];
        List<Question> questions = [];

        for (var questionData in responseData) {
          questions.add(Question.fromJson(questionData));
        }
        return right(questions);
      } else {
        throw left(Failure('Failed to get quiz data: ${response.statusCode}'));
      }
    } catch (e) {
      throw Failure('Failed to get quiz data: $e');
    }
  }
}
