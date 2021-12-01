import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  final int h;
  final int w;

  const Logo({Key? key, this.h=200, this.w=350}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Container(
      height:  h.toDouble(),
      width: w.toDouble(),
      child: Image.asset('assets/image/logo1.png',fit:  BoxFit.fill,),
    );
  }
}
