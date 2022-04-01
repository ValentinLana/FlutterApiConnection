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

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authenticationAPI = GetIt.instance<AutheticationAPI>();
    final AuthenticationClient _authenticationClient =
      GetIt.instance<AuthenticationClient>();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';
  Logger _logger = Logger();
  _submit() async {
    final isOk = _formKey.currentState?.validate();
    print("form isOk $isOk");
    if (isOk!) {
      ProgressDialog.show(context);
      
      final response =
          await _authenticationAPI.login(email: _email, password: _password);
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        // peticion de manera exitosa porque es distinto de null
        _logger.i('register ok::: ${response.data}');
        //guardamos la sesion antes de redireccionar
        await _authenticationClient.saveSession(response.data!);
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage2.routeName, (_) => false);
      }else{
         String message = response.error!.message;
        if (response.error!.statusCode == -1) {
          message = 'bad network';
        } else if (response.error!.statusCode == 403) {
          message = 'invalid password';
        } else if (response.error!.statusCode == 404) {
          message = 'User not found';
        } 

        Dialogs.alert(context,
            title: 'error', description: message);
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
              Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: Row(
                    children: [
                      Expanded(
                          child: InputText(
                        label: 'PASSWORD',
                        obscureText: true,
                        borderEnabled: false,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        onChanged: (text) {
                          _password = text;
                          print("password: $text");
                        },
                        validator: (text) {
                          if (text!.trim().length == 0) {
                            return "Invalid password";
                          }
                          return null;
                        },
                      )),
                      FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          onPressed: () {},
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: responsive
                                    .dp(responsive.isTablet ? 1.2 : 1.5)),
                          ))
                    ],
                  )),
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
                        'Sign In',
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
                    'New to Friendly desi?',
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: Text(
                        'Sing up',
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
