import 'package:dio/dio.dart';

import 'ApiClient.dart';
class WebService {
  var dio = DioProvider.instance();
//
//  Future<List<NewsArticle>> fetchTopHeadlines() async {
//    try {
//      String url =
//          'https://newsapi.org/v2/top-headlines?country=us&apiKey=16451bb2039f440a95c6f22529cbce3e';
//      final response = await dio.get(url,options:Options(
//          followRedirects: false,
//          validateStatus: (status) { return status < 500; }
//      ));
//
//      if (response.statusCode == 200) {
//        final result = response.data;
//        Iterable list = result['articles'];
//        return list.map((article) => NewsArticle.fromJson(article)).toList();
//      } else {
//        return [];
//      }
//    } on Exception catch (e) {
//      if(e is DioError){
//        return [];
//      }
//      else{
//        return [];
//      }
//    }
//  }


  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}