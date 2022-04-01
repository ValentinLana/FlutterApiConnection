import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:proyect_api/data/authentication_client.dart';

import 'home2_page.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //recuperamos el dato con el getIt
  final AuthenticationClient _authenticationClient =
      GetIt.instance<AuthenticationClient>();
  @override
  void initState() {
    //comprobar una sesion previa

    // TODO: implement initState
    super.initState();

    //debemos asegurar que el widget ya este renderizado
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    //Comprobar si hay una session activa, hay que recuperar el authetication
    //client con la inyeccion de dependencias

    final token = await _authenticationClient.accessToken;
    if (token == null) {
      //si devuelve null es pq no hay token anterior
      //se reemplaza la pagina de splash por la del login
      //se podria usar pushnamedandremove pero solo esta la del splash
      //asiq solo usamos pushreplacement
      Navigator.pushReplacementNamed(context, HomePage.routeName);
      return;
    }
    Navigator.pushReplacementNamed(context, HomePage2.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
