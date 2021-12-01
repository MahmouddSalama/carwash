import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/bodyGarage/bodys/main_layout/main_lauout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.data==null)
          return SignInScreen();
        else if(snapshot.hasData)
          return MainLayoutGarage();
        else
          return Scaffold(
            body: Center(
              child: Text('Some error happened'),
            ),
          );
      },
    );
  }
}
