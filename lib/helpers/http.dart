import 'package:dio/dio.dart';
import 'package:proyect_api/utils/logs.dart';

import 'http_response.dart';

class Http {
  Dio? _dio;
  bool? _logsEnabled;
  Http({required dio, required logger, required logsEnabled}) {
    _dio = dio;
    _logsEnabled = logsEnabled;
  }
  Future<HttpResponse<T>> request<T>(String path,
      {String method = 'GET',
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      T Function(dynamic data)? parser}) async {
    try {
      final Response response = await _dio!.request(
        path,
        options: Options(
          method: method,
          headers: headers
        ),
        queryParameters: queryParameters,
        data: data,
      );
      Logs.p.i(response.data);

      if(parser != null){
      return HttpResponse.success<T>(parser(response.data));
      }

       return HttpResponse.success<T>(response.data);
       
    } catch (e) {
      Logs.p.e(e);

      int statusCode = 0; //
      String message = 'unknown error';
      dynamic data;

      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          // si es == null quiere decir que el error es de network
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data!;
        }
      }
      return HttpResponse.fail(
          statusCode: statusCode, message: message, data: data);
    }
  }
}
