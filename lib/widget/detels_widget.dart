import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List carsType = [
    'jeep',
    'Toyota',
    'Marcedes',
    'Sozoky',
  ];

  String dropdownValue = 'jeep';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: size.width,
        height: size.height * .55,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: SingleChildScrollView(
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Car Type',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Kblack,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        style: TextStyle(
                            color: KtextColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        icon: Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 30,
                          color: Kblack,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: carsType.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildPadding(text: 'IN',num: '10 SR',size: size),
                    SizedBox(width: 10,),
                    buildPadding(text: 'OUT',num: '10 SR',size: size),
                    SizedBox(width: 10,),
                    buildPadding(text: 'ALL',num: '10 SR',size: size),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Serveses',
                    style: TextStyle(
                      fontSize: 22,
                      color: KbtnColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                buildRow(text: 'Towel', num: "10 RS"),
                buildRow(text: 'Spray', num: "10 RS"),
                buildRow(text: 'Soap', num: "10 RS"),
                buildRow(text: 'Total price', color: KbtnColor, num: '30 RS'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPadding({text,num,required Size size}) {
    return Container(
      width:100 ,
      height: 100,
      decoration: BoxDecoration(
        color: Kwhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Kblack.withOpacity(.5), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Divider(
              color: KtextColor,
              thickness: 1.5,
            ),
            Text(
              num.toString(),
              style: TextStyle(
                  color: KbtnColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRow({text, color = Kwhite, num}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 130,
            height: 40,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: Kblack,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              num.toString(),
              style: TextStyle(
                  color: color == KbtnColor ? Kwhite : KbtnColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
