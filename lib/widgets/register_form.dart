import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:proyect_api/api/authentication_api.dart';
import 'package:proyect_api/data/authentication_client.dart';
import 'package:proyect_api/helpers/http_response.dart';
import 'package:proyect_api/pages/home2_page.dart';
import 'package:proyect_api/utils/dialogs.dart';
import 'package:proyect_api/utils/responsive.dart';

import 'input_text.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authenticationAPI = GetIt.instance<AutheticationAPI>();
  final AuthenticationClient _authenticationClient =
      GetIt.instance<AuthenticationClient>();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';
  Logger _logger = Logger();

  Future<void> _submit() async {
    final isOk = _formKey.currentState?.validate();
    print("form isOk $isOk");
    if (isOk!) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.register(
          username: _username, email: _email, password: _password);
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        // peticion de manera exitosa porque es distinto de null
        _logger.i('register ok::: ${response.data}');
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage2.routeName, (_) => false);
      } else {
        //si no hay acceso a internet el status code es -1
        _logger.e('register error STATUS CODE ${response.error!.statusCode}');
        _logger.e('register error MESSAGE ${response.error!.message}');
        _logger.e('register error DATA ${response.error!.data}');
        String message = response.error!.message;
        if (response.error!.statusCode == -1) {
          message = 'bad network';
        } else if (response.error!.statusCode == 409) {
          message =
              'account exits ${jsonEncode(response.error!.data['duplicatedFields'])}';
        }

        Dialogs.alert(context, title: 'error', description: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(maxWidth: responsive.isTablet ? 430 : 360),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputText(
                label: 'USERNAME',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  _username = text;
                  print("email: $text");
                },
                validator: (text) {
                  if (text!.trim().length < 5) {
                    return "Invalid username";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: 'EMAIL ADDRESS',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  _email = text;
                  print("email: $text");
                },
                validator: (text) {
                  if (!text!.contains("@")) {
                    print("holanda");
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2)),
              InputText(
                label: 'PASSWORD',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  _password = text;
                  print("email: $text");
                },
                validator: (text) {
                  if (text!.trim().length < 6) {
                    print("holanda");
                    return "Invalid password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      onPressed: () {
                        // ignore: unnecessary_statements
                        this._submit();
                      },
                      color: Colors.pinkAccent,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(1.7),
                        ),
                      ))),
              SizedBox(
                height: responsive.dp(2),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'home');
                      },
                      child: Text(
                        'Sing in',
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: responsive.dp(1.5)),
                      ))
                ],
              ),
              SizedBox(
                height: responsive.dp(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
