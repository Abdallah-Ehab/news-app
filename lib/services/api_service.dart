import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/data_state.dart';

class ApiService {
  final String _apiUrl;

  ApiService({required String url}):_apiUrl = url;
  Future<DataState<List<Article>>> fetchData() async {
    final dio = Dio();
    try {
      Response response = await dio.get(_apiUrl);

      if (response.statusCode! >= 400) {
        return DataState.fail(errorMessage: "error 404 not found");
      }
      log("Data fetched correctly");
      final data = response.data;
      List<Article> articles =
          (data["articles"] as List<dynamic>).map((element) {
        return Article.fromJson(element);
      }).toList();
      return DataState.success(data: articles);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          return DataState.fail(errorMessage: "connection error");
        case DioExceptionType.badResponse:
          return DataState.fail(errorMessage: "bad response");
        case DioExceptionType.connectionTimeout:
          return DataState.fail(errorMessage: "connection time out");
        default:
          return DataState.fail(errorMessage: "unknown error happened");
      }
    }
  }
}
