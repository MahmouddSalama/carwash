import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';


class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DrawerHeader(
        decoration: BoxDecoration(
        ),
        child: Container(
          child: Image.asset('assets/image/logo1.png',fit: BoxFit.fill,)
        ),
      ),
    );
  }
}
