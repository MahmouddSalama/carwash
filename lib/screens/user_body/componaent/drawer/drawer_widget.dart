import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/bodyGarage/Componant/drawer/widget/drawer_header.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/add_garage_screens.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/garage_orders.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/my_garages.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/my_profile.dart';
import 'package:carwash/screens/user_body/bodys/screens/new_order/garages.dart';
import 'package:carwash/screens/user_body/bodys/screens/user_cars/user_cars.dart';
import 'package:carwash/screens/user_body/bodys/screens/user_orders/user_order.dart';
import 'package:carwash/screens/user_body/componaent/drawer/widget/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidgetUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          MyDrawerHeader(),
          CategoryListTileUser(
            text: 'My Account',
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            },
            iconData: Icons.person,
          ),
          CategoryListTileUser(
            text: 'My Cars',
            function: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserCars()));
            },
            iconData: Icons.car_repair,
          ),
          CategoryListTileUser(
            text: 'My Orders',
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserOrders()));
            },
            iconData: Icons.fiber_manual_record_rounded,
          ),
          CategoryListTileUser(
            text: 'Add Order',
            function: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Garages()));
            },
            iconData: Icons.add,
          ),
          Divider(height: 3, color: Colors.indigoAccent),
          CategoryListTileUser(
            text: 'Logout',
            function: () async {
              FirebaseAuth.instance.signOut();
              for (; Navigator.canPop(context);) {
                Navigator.pop(context);
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            iconData: Icons.logout,
          ),
        ],
      ),
    );
  }
}
