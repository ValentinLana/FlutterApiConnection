import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:proyect_api/api/account_api.dart';
import 'package:proyect_api/data/authentication_client.dart';
import 'package:proyect_api/models/user.dart';
import 'package:proyect_api/pages/home_page.dart';
import 'package:proyect_api/utils/logs.dart';

class HomePage2 extends StatefulWidget {
  static const routeName = 'home2';
  HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _accountAPI = GetIt.instance<AccountAPI>();
  User? user;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) { 
      _loadUser();
    });
  }
  
  Future<void> _loadUser() async {
    final response = await _accountAPI.getUserInfo();
    if(response.data != null){
      user = response.data!;
      setState(() {
        
      });
      Logs.p.i(response.data!.email);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(user == null) CircularProgressIndicator(),
            if(user != null) Column(children: [
              Text(user!.username)
            ],),

            ElevatedButton(onPressed: 
            () async {
             await _authenticationClient.signOut();
             Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false);
            }, child: Text('sign out'))
          ],
        ),
      )
    );
  }
}
