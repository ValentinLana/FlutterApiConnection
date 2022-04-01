import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconContainer extends StatelessWidget {
  final double size;
  const IconContainer({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(this.size * 0.15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, blurRadius: 25, offset: Offset(0, 15)
          ),

        ]
      ),
      padding: EdgeInsets.all(this.size * 0.15),
      child: Center(child: 
      SvgPicture.asset('assets/icon.svg', width: this.size * 0.8, height: this.size * 0.8,),),
    );
  }
}