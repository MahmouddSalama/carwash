import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Container(
      height:  200,
      width: 350,
      child: Image.asset('assets/image/logo1.png',fit:  BoxFit.fill,),
    );
  }
}
