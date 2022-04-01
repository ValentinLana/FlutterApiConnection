import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final List<Color> colors;
  final double size;
  const Circle({Key? key, required this.size, required this.colors})
      : assert(size != null && size > 0),assert(colors != null && colors.length >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        color: Colors.orange,
         shape: BoxShape.circle,
         gradient: LinearGradient(colors: this.colors, begin: Alignment.topCenter, end: Alignment.bottomCenter)
         ),
    );
  }
}
