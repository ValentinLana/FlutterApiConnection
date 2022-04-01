import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:proyect_api/helpers/http.dart';
import 'package:proyect_api/helpers/http_response.dart';
import 'package:proyect_api/models/authentication_response.dart';

class AutheticationAPI {
  final Http _http;

  AutheticationAPI(this._http);

  Future<HttpResponse<AuthenticationResponse>> register(
      {required String username,
      required String email,
      required String password}) {
    return _http.request<AuthenticationResponse>('/api/v1/register',
        method: 'POST',
        data: {"username": username, "email": email, "password": password},
        parser: (data) {
      return AuthenticationResponse.fromJson(data);
    });
  }

  Future<HttpResponse<AuthenticationResponse>> login(
      {required String email, required String password}) {
    return _http.request<AuthenticationResponse>('/api/v1/login',
        method: 'POST',
        data: {"email": email, "password": password}, parser: (data) {
      return AuthenticationResponse.fromJson(
          data); // lo unico que hace es modela el json
    });
  }

  Future<HttpResponse<AuthenticationResponse>> refreshToken(
      {required String expiredToken}) {
    return _http.request<AuthenticationResponse>('/api/v1/refresh-token',
        method: 'POST',
        headers: {
          "token" : expiredToken
        },
        parser: (data) {
      return AuthenticationResponse.fromJson(data);
    });
  }
}
