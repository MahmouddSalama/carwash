import 'package:carwash/screens/auth/ui/auth_state/cupit/cubit.dart';
import 'package:carwash/screens/auth/ui/auth_state/cupit/state.dart';
import 'package:carwash/screens/bodyGarage/bodys/main_layout/main_lauout.dart';
import 'package:carwash/screens/user_body/bodys/cubit/state.dart';
import 'package:carwash/screens/user_body/bodys/layout/user_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AppMainLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubite>(
      create: (_) => UserCubite(),
      child: BlocConsumer<UserCubite, UserType>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          _isGarageOwner(ctx);
          _isAdmin(ctx);
          var cubit = UserCubite.get(ctx);
          if(UserCubite.get(ctx).Gargeowner){
            return MainLayoutGarage();
          }
          else return UserMainLayout();
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
