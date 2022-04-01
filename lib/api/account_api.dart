import 'package:proyect_api/data/authentication_client.dart';
import 'package:proyect_api/helpers/http.dart';
import 'package:proyect_api/helpers/http_response.dart';
import 'package:proyect_api/models/user.dart';

class AccountAPI{
  final Http _http;
  final AuthenticationClient _authenticationClient;

  AccountAPI(this._http, this._authenticationClient);

  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken;
    return _http.request<User>('/api/v1/user-info', method: "GET", headers: {
      "token" : token
    },
    //debemos parsear la data para que devuelva un user
     parser: (data){
      return User.fromJson(data);
    });

  }
  
}