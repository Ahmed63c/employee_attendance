import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:employeeattendance/Utils/Constant.dart';

class DioProvider {
  static Dio instance() {
    final dio = Dio();
    dio.options=new BaseOptions(
      baseUrl:Constant.BASE_URL,
      receiveDataWhenStatusError: true,
      connectTimeout: 60*1000, // 60 seconds
      receiveTimeout: 60*1000, // 60 s
    );
    dio.interceptors.add(HttpLogInterceptor());
    return dio;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    log("onRequest: ${options.uri}\n"
        "data=${options.data}\n"
        "method=${options.method}\n"
        "headers=${options.headers}\n"
        "queryParameters=${options.queryParameters}");

    return options;
  }

  @override
  Future onResponse(Response response) {
    log("onResponse: $response");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    log("onError: $err\n"
        "Response: ${err.response}");
    return super.onError(err);
  }
}
