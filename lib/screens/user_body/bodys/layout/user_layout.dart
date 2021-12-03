import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/user_body/bodys/cubit/cupit.dart';
import 'package:carwash/screens/user_body/bodys/cubit/state.dart';
import 'package:carwash/screens/user_body/componaent/drawer/drawer_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
class UserMainLayout extends StatefulWidget {
  @override
  _UserMainLayoutState createState() => _UserMainLayoutState();
}

class _UserMainLayoutState extends State<UserMainLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>UserCubit(),
      child: BlocConsumer<UserCubit,UserState>(
        listener: (ctx,s){},
        builder: (context,s) {
          return Scaffold(
            drawer: DrawerWidgetUser(),
            appBar: AppBar(
              title: Text(UserCubit.get(context).title[UserCubit.get(context).curentIndex],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: KbtnColor,
              elevation: 0,
              selectedItemColor: KselectColor,
              unselectedItemColor: Kwhite,
              currentIndex: UserCubit.get(context).curentIndex,
              onTap: (value){
                UserCubit.get(context).changeScreen(value);
              },
              type: BottomNavigationBarType.fixed,
              items: UserCubit.get(context).userTap,
            ),
            body: UserCubit.get(context).screensUser[UserCubit.get(context).curentIndex],
          );
        },
      ),
    );
  }
}
