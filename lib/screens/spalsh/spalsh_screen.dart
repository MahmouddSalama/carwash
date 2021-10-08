import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/body/main_lauout.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading=true;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx)=>SignInScreen())).then((value){setState(() {
        loading=false;
      });});
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: 'Car Wash',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.w400))
                ]),
              ),
              SizedBox(height: 20),
              Text(
                "Make Order Few Seconds...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 50),
              if(loading)
                Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(color: KbtnColor,),
                )
            ],
          ),
        ),
      ),
    );
  }
}
