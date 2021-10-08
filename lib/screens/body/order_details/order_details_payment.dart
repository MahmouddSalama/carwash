import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/body/order_details/edit_informaition_screen.dart';
import 'package:carwash/screens/body/order_details/finish_order.dart';
import 'package:carwash/widget/DetailsPayment.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/detels_widget.dart';
import 'package:flutter/material.dart';
class OrderDetailsPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details',style: TextStyle(
          color: KtextColor
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Text('Here is all details',
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
              textAlign: TextAlign.center,
            ),
            Details(),
            DetailsPayment(),
            SizedBox(height: 20),
            DefaultButton(function: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>FinishOrder()));

            },text: 'Confirm Payment',),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
