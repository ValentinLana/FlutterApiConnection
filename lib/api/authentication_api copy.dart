/* import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:proyect_api/helpers/http_response.dart';
import 'package:proyect_api/utils/logs.dart';

class AutheticationAPI {
  final Dio _dio = Dio();

  Future<HttpResponse> register(
      {required String username,
      required String email,
      required String password}) async {

    try {

      final Response response = await _dio.post(
        'https://curso-api-flutter.herokuapp.com/api/v1/register',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {"username": username, "email": email, "password": password},
      );
      Logs.p.i(response.data);
      return HttpResponse.success(response.data);

    } catch (e) {

      Logs.p.e(e);

      int statusCode = -1;
      String message = 'unknown error';
      dynamic data;

      if (e is DioError) {
        message = e.message;
        if (e.response != null) { // si es == null quiere decir que el error es de network
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data!;
        }
      }
      return HttpResponse.fail(
          statusCode: statusCode, message: message, data: data);

    }
  }


  Future<HttpResponse> login(
      {required String email,
      required String password}) async {

    try {

      final Response response = await _dio.post(
        'https://curso-api-flutter.herokuapp.com/api/v1/login',
        //en DIO los headers content-type aplicattion json estan por defecto, no hace falta ponerlos
        data: {"email": email, "password": password},
      );
      Logs.p.i(response.data);
      return HttpResponse.success(response.data);

    } catch (e) {

      Logs.p.e(e);

      int statusCode = -1;
      String message = 'unknown error';
      dynamic data;

      if (e is DioError) {
        message = e.message;
        if (e.response != null) { // si es == null quiere decir que el error es de network
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
 */