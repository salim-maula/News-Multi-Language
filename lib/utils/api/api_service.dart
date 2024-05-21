import 'package:dio/dio.dart';
import 'package:kolink_news/model/news_model.dart';
import 'package:kolink_news/utils/api/api_call.dart';
import 'package:kolink_news/utils/api/api_result.dart';
import 'package:kolink_news/utils/dio/dio_client.dart';
import 'package:kolink_news/utils/dio/dio_exception.dart';

class ApiService {
  final dioClient = DioClient(Dio());

  Future<ApiResult<NewsModel>> getNews(String country, String category) async {
    String url = Endpoints.getNews.endpoint
        .replaceAll("{country}", country)
        .replaceAll("{category}", category);

    try {
      final response = await dioClient.get(url);
      final result = NewsModel.fromJson(response);
      print(result.toJson());
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      // print(DioExceptions.fromDioError(e));
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<NewsModel>> nextPage(
      String country, String category, String page) async {
    String url = Endpoints.nextPage.endpoint
        .replaceAll("{country}", country)
        .replaceAll("{category}", category)
        .replaceAll("{page}", page);

    try {
      final response = await dioClient.get(url);
      final result = NewsModel.fromJson(response);
      print('BERHASIL NEXT PAGE');
      print(result.toJson());
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      print('GAGAL NEXT PAGE');
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }
}
