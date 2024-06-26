import 'package:dio/dio.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/reading/repository/%20model/gpt_model.dart';

class GptRepository {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  GptRepository();

  Future<GptModel> fetchSubjectsParaphrase(
      {required String topic, required String subject}) async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.post(
        ApiConstans.subjectsData,
        data: {'topic': topic, "subject": subject},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final subjectsData = response.data['data'];
        final subject = GptModel.fromJson(subjectsData);
        return subject;
      } else {
        throw Failure('Failed to get user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Failure('Failed to get user data: $e');
    }
  }

  Future<GptModel> fetchLiteratureParaphrase(
      {required String topic, required String size}) async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.post(
        ApiConstans.literatureData,
        data: {'topic': topic, "size": size},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final literatureData = response.data['data'];
        final literature = GptModel.fromJson(literatureData);
        return literature;
      } else {
        throw Failure('Failed to get user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Failure('Failed to get user data: $e');
    }
  }
}
