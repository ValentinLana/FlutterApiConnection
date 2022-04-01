import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:proyect_api/api/account_api.dart';
import 'package:proyect_api/api/authentication_api.dart';
import 'package:proyect_api/data/authentication_client.dart';
import 'package:proyect_api/helpers/http.dart';
import 'package:proyect_api/utils/logs.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio =
        Dio(BaseOptions(baseUrl: 'https://curso-api-flutter.herokuapp.com'));

    Http http = Http(
      dio: dio,
      logger: Logs.p,
      logsEnabled: true,
    );

    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final AutheticationAPI authenticationAPI = AutheticationAPI(http);
    final authenticationClient =
        AuthenticationClient(secureStorage, authenticationAPI);
    final accountAPI = AccountAPI(http, authenticationClient);
    
    GetIt.instance.registerSingleton<AutheticationAPI>(authenticationAPI);
    GetIt.instance.registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<AccountAPI>(accountAPI);
  
  }
}
