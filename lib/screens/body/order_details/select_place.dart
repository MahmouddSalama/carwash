import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/body/order_details/order_details.dart';
import 'package:carwash/widget/location_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            LocationField(),
            SizedBox(height: 10),
            Text(
              'The Nearest Car Washing from You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: KtextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderDetails()));
                        },
                        child: Container(
                          width: size.width,
                          height: size.height * .15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: KbackColor,
                            border: Border.all(color: KtextColor, width: 1.5),
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Text('Place 1',style: TextStyle(
                            fontSize: 18,
                            color: KtextColor,
                            fontWeight: FontWeight.w600,
                          ),),
                                height: 60,
                                alignment: Alignment.center,
                              ),
                              Divider(thickness: 2, color: KtextColor.withOpacity(.6)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 30,
                                    ),
                                    Text('15 20_min')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
