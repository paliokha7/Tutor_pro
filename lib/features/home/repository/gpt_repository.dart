import 'package:dio/dio.dart';
import 'package:tutor_pro/core/constans/api_constans.dart';
import 'package:tutor_pro/core/failure.dart';
import 'package:tutor_pro/features/auth/%20repository/token_manager.dart';
import 'package:tutor_pro/features/home/repository/%20model/gpt_model.dart';

class GptRepository {
  Dio dio = Dio();
  TokenManeger tokenManeger = TokenManeger();

  GptRepository();

  Future<GptModel> fetchGeographyParaphrase({required String topic}) async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.post(
        ApiConstans.geographyData,
        data: {'topic': topic},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final geographyData = response.data['data'];
        final geography = GptModel.fromJson(geographyData);
        return geography;
      } else {
        throw Failure('Failed to get user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Failure('Failed to get user data: $e');
    }
  }

  Future<GptModel> fetchLiteratureParaphrase({required String topic}) async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.post(
        ApiConstans.literatureData,
        data: {'topic': topic},
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

  Future<GptModel> fetchBiologyParaphrase({required String topic}) async {
    try {
      final token = await tokenManeger.getAccessToken();

      final response = await dio.post(
        ApiConstans.biologyData,
        data: {'topic': topic},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final biologyData = response.data['data'];
        final biology = GptModel.fromJson(biologyData);
        return biology;
      } else {
        throw Failure('Failed to get user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Failure('Failed to get user data: $e');
    }
  }

  Future<GptModel> fetchHistoryParaphrase({required String topic}) async {
    try {
      final token = await tokenManeger.getAccessToken();
      final response = await dio.post(
        ApiConstans.historyData,
        data: {'topic': topic},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      if (response.statusCode == 200) {
        final historyData = response.data['data'];
        final history = GptModel.fromJson(historyData);
        print(history);
        return history;
      } else {
        throw Failure('Failed to get user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Failure('Failed to get user data: $e');
    }
  }
}
