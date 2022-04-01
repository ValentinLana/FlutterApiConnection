import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proyect_api/api/authentication_api%20copy.dart';
import 'package:proyect_api/api/authentication_api.dart';
import 'package:proyect_api/models/authentication_response.dart';
import 'package:proyect_api/models/session.dart';

class AuthenticationClient {
  final FlutterSecureStorage _secureStorage;
  final AutheticationAPI _autheticationAPI;

  Completer? _completer;

  AuthenticationClient(this._secureStorage, this._autheticationAPI);

  void _complete() {
    if(_completer != null && !_completer!.isCompleted){
_completer!.complete();
    }
  }
  
  Future<String?> get accessToken async {
    if (_completer != null) {
      //esperamos a que termine completer
      await _completer!.future;
    }

//iniciamos un nuevo completer

    _completer = Completer();

    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      //comprobamos si tiene al menos un minuto de vida el token
      final session = Session.fromJson(jsonDecode(data));

      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createdAt;
      final int expiresIn = session.expiresIn;
      final int diff = currentDate.difference(createdAt).inSeconds;

      if (expiresIn - diff >= 60) {
        _complete();
        return session.token;
      }
      final response =
          await _autheticationAPI.refreshToken(expiredToken: session.token);
      if (response.data != null) {
        await saveSession(response.data!);
        _complete();
        return response.data!.token;
      }
      _complete();
      return null;
    }
    _complete();
    return null;
  }

  Future<void>? saveSession(AuthenticationResponse authenticationResponse) {
    final Session session = Session(
        token: authenticationResponse.token,
        expiresIn: authenticationResponse.expiresIn,
        createdAt: DateTime.now());

//convierte a string y luego guarda en securestorage
    final data = jsonEncode(session.toJson());
    _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void>? signOut() async {
    await _secureStorage.deleteAll();
  }
}
