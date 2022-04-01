
import 'package:flutter/material.dart';
import 'package:proyect_api/utils/responsive.dart';
import 'package:proyect_api/widgets/circle.dart';
import 'package:proyect_api/widgets/icon_container.dart';
import 'package:proyect_api/widgets/login_form.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);


    final double pinkSize = responsive.wp(80);
    final double orangeSize = responsive.wp(57);
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: -(pinkSize) * 0.4,
                    right: -(pinkSize) * 0.1,
                    child: Circle(
                      size: pinkSize,
                      colors: [Colors.pink, Colors.pinkAccent],
                    )),
                Positioned(
                    top: -(orangeSize) * 0.5,
                    left: -(orangeSize) * 0.15,
                    child: Circle(
                      size: orangeSize,
                      colors: [Colors.orange, Colors.deepOrangeAccent],
                    )),
                    Positioned(
                      top: pinkSize * 0.35,
                      child: Column(
                        children: [
                          IconContainer(
                            size: responsive.wp(17),
                          ),
                          SizedBox(height: responsive.dp(3),),
                          Text('Hello Again\nWelcome Back!', textAlign: TextAlign.center, style: TextStyle(fontSize: responsive.dp(1.7)),)
                        ],
                      ),),
                      LoginForm()
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
}
