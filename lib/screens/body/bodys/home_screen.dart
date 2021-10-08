import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/body/order_details/select_place.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/detels_widget.dart';
import 'package:carwash/widget/location_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                SizedBox(height: 10,),
                LocationField(),
                SizedBox(height: 10),
                Text('New Order',style: TextStyle(
                  fontSize: 22,
                  color: KbtnColor,
                  fontWeight: FontWeight.w600,
                ),),
                Details(),
                DefaultButton(function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SelectPlace()));
                }, text: 'text')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
