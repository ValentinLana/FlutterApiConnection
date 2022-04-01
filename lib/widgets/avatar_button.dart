import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({Key? key, required this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20,
                                      color: Colors.black26,
                                      offset: Offset(0, 20))
                                ],
                                shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.network(
                                'https://png.pngtree.com/png-vector/20190710/ourlarge/pngtree-user-vector-avatar-png-image_1541962.jpg',
                                width: this.imageSize,
                                height: this.imageSize,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 0,
                            child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 2),
                                      color: Colors.pink,
                                      shape: BoxShape.circle),
                                ),
                                onPressed: () {}),
                          )
                        ],
                      );
  }
}