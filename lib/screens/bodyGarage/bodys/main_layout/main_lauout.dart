import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/bodyGarage/Componant/drawer/drawer_widget.dart';
import 'package:carwash/screens/bodyGarage/bodys/cubit/cubit.dart';
import 'package:carwash/screens/bodyGarage/bodys/cubit/stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
class MainLayoutGarage extends StatefulWidget {
  @override
  _MainLayoutGarageState createState() => _MainLayoutGarageState();
}

class _MainLayoutGarageState extends State<MainLayoutGarage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>GarageCubit(),
      child: BlocConsumer<GarageCubit,GarageSates>(
        listener: (ctx,s){},
        builder: (context,s) {
          return Scaffold(
            drawer: DrawerWidget(),
            appBar: AppBar(
              title: Text(GarageCubit.get(context).title[GarageCubit.get(context).curentIndex],
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
            currentIndex: GarageCubit.get(context).curentIndex,
            onTap: (value){
              GarageCubit.get(context).changeScreen(value);
           },
           type: BottomNavigationBarType.fixed,
            items: GarageCubit.get(context).garageTap,
          ),
          body: GarageCubit.get(context).screensGarageOwner[GarageCubit.get(context).curentIndex],
        );
        },
      ),
    );
  }
}
