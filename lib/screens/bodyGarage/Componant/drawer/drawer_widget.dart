
import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/bodyGarage/Componant/drawer/widget/category.dart';
import 'package:carwash/screens/bodyGarage/Componant/drawer/widget/drawer_header.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/add_garage_screens.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/garage_orders.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/my_garages.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/my_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidgetGarage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          MyDrawerHeader(),
          CategoryListTileGarage(
            text: 'My Account',
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
            },
            iconData: Icons.person,
          ),
          CategoryListTileGarage(
            text: 'My Garages',
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGarages()));
            },
            iconData: Icons.car_repair,
          ),
          CategoryListTileGarage(
            text: 'Orders',
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GarageOrders()));
            },
            iconData: Icons.fiber_manual_record_rounded,
          ), CategoryListTileGarage(
            text: 'Add Garage',
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddGarage()));
            },
            iconData: Icons.add,
          ),

          Divider(height: 3, color: Colors.indigoAccent),
          CategoryListTileGarage(
            text: 'Logout',
            function: () {
              FirebaseAuth.instance.signOut();
              for(;Navigator.canPop(context);){
                Navigator.pop(context);
              }
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen(
              )));
            },
            iconData: Icons.logout,
          ),
        ],
      ),
    );
  }
}