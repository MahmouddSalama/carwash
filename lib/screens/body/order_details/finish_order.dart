import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:flutter/material.dart';
class FinishOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your All Set up',
              style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: KbtnColor
            ),),
            SizedBox(height: 30),
            Text('Thank you for using\n Car Wash app',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Kblack
            ),textAlign: TextAlign.center,),
            Container(
              width: 350,
              height: 300,
              child: Image.asset('assets/image/logo2.png',fit: BoxFit.fill,),
            ),
            SizedBox(height: 30),
            DefaultButton(text: 'Back To Home',function: (){
              for(;Navigator.canPop(context);)
                Navigator.pop(context);
            },),
          ],
        ),
      ),
    );
  }
}
