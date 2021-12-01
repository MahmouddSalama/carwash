import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';

class GarageOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: KtextColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow(text1:'Name : ',text2: 'Mahmoud'),
                      buildRow(text1:'Car Type : ',text2: 'jeep'),
                      buildRow(text1:'Address : ',text2: 'cairo'),
                      buildRow(text1:'Time : ',text2: '12PM'),
                      buildRow(text1:'Way Of Pay : ',text2: 'off Line'),
                      Divider(thickness: 2,color: KbtnColor,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(onPressed: (){}, child: Text(
                            'Ok',
                          )),
                          TextButton(onPressed: (){}, child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildRow({text1,text2}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(width: 10,),
          Text(
            text2,
            style: TextStyle(
                color: KbtnColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
