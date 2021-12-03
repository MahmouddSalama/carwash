import 'package:carwash/main_LatOut.dart';
import 'package:carwash/screens/auth/ui/auth_state/cupit/cubit.dart';
import 'package:carwash/screens/auth/ui/auth_state/cupit/state.dart';
import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/bodyGarage/bodys/main_layout/main_lauout.dart';
import 'package:carwash/screens/user_body/bodys/layout/user_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>UserCubite(),
      child: BlocConsumer<UserCubite,UserType>(
        listener: (ctx,s){},
        builder:(c,s){
          return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){

            if(snapshot.data==null)
              return SignInScreen();
            else if(snapshot.hasData) {
             return AppMainLayOut();
            }
            else
              return Scaffold(
                body: Center(
                  child: Text('Some error happened'),
                ),
              );
          },
        );
        },
      ),
    );
  }
  _isAdmin(ctx) async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserCubite.get(ctx).isAdmin(user['admin']);
  }
  _isGarageOwner(ctx) async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserCubite.get(ctx).isGarageOwner(user['type'].toString());
  }
}
