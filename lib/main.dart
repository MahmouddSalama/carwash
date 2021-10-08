import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/auth/ui/register_screen.dart';
import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/body/main_lauout.dart';
import 'package:carwash/screens/spalsh/spalsh_screen.dart';
import 'package:flutter/material.dart';
main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: KbtnColor)
      )
    ),
      debugShowCheckedModeBanner: false,
      home:SplashScreen() ,
    );
  }
}