


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyect_api/helpers/dependency_inyection.dart';
import 'package:proyect_api/pages/splash_page.dart';

import 'pages/home2_page.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';

void main() {
  DependencyInjection.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        HomePage.routeName: (_) => HomePage(), 
        HomePage2.routeName : (_) => HomePage2(),       
      },
    );
  }
}
