import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NotificationScreenOFGarage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Visibility(
              visible:true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width,
                  height: size.height * .15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: KbackColor,
                      border: Border.all(color: Colors.grey, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildRichText(
                                text1: 'Order From', text2: 'Ahmad Elsaid'),
                            buildRichText(text1: 'with car type', text2: 'jeep'),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('5:00 PM'),
                              Row(
                                children: [
                                  buildFlexible(function: (){

                                  },color: Kwhite,text: 'cancel'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  buildFlexible(function: (){},text: 'Done')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Flexible buildFlexible({text,color=KbtnColor,required Function function}) {
    return Flexible(
        child: GestureDetector(
      onTap: () =>function(),
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 1.5, color: KbtnColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text.toString(),style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color==KbtnColor?Kwhite:KbtnColor,
          fontSize: 16
        ),),
      ),
    ));
  }

  RichText buildRichText({text1, text2}) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: '$text1 ',
            style: TextStyle(
                color: Kblack, fontSize: 18, fontWeight: FontWeight.w600)),
        TextSpan(
            text: text2,
            style: TextStyle(
                color: KbtnColor, fontSize: 18, fontWeight: FontWeight.w600)),
      ],
    ));
  }
}
