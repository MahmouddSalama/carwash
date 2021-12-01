import 'package:carwash/screens/bodyGarage/bodys/screens/add_garage_screens.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/garage_orders.dart';
import 'package:carwash/screens/bodyGarage/bodys/screens/my_garages.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenGarage extends StatefulWidget {
  @override
  _HomeScreenGarageState createState() => _HomeScreenGarageState();
}

class _HomeScreenGarageState extends State<HomeScreenGarage> {
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
                        text: 'Orders',
                        function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GarageOrders()));
                        },
                      ),
                    ),
                    Flexible(
                      child: DefaultButton(
                        text: 'Add Garage',
                        function: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddGarage()));
                        },
                      ),
                    ),
                  ],
                ),
                DefaultButton(
                  text: 'My Garages',
                  function: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyGarages()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
