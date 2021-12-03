import 'package:carwash/screens/user_body/bodys/screens/add_car.dart';
import 'package:carwash/screens/user_body/bodys/screens/new_order/garages.dart';
import '../screens/new_order/add_order.dart';
import '../screens/allgarages/all_garages.dart';
import '../screens/user_orders/user_order.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/material.dart';
class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                SizedBox(height: size.height*.15),
                Row(
                  children: [
                    Flexible(
                      child: DefaultButton(
                        text: 'Add Orders',
                        function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Garages(
                          )));
                        },
                      ),
                    ),
                    Flexible(
                      child: DefaultButton(
                        text: 'Add Car',
                        function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCar()));

                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: DefaultButton(
                        text: 'My Orders',
                        function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserOrders()));

                        },
                      ),
                    ),
                    Flexible(
                      child: DefaultButton(
                        text: 'All Garages',
                        function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllGarages()));

                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}