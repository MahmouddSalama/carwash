import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/widget/visa_felid.dart';
import 'package:flutter/material.dart';

class DetailsPayment extends StatelessWidget {
  var _cardNumControl = TextEditingController();
  var _fNameControl = TextEditingController();
  var _lNameControl = TextEditingController();
  var _monthControl = TextEditingController();
  var _yearControl = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Payment',
                    style: TextStyle(
                        color: KtextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildContainer(size, 'assets/image/visa.png'),
                    SizedBox(width: 10),
                    buildContainer(size, 'assets/image/mater.png'),
                    SizedBox(width: 10),
                    buildContainer(size, 'assets/image/amirecan.png'),
                  ],
                ),
                SizedBox(height: 10),
                VisaField(
                  lable: 'Card Number',
                  textEditingController: _cardNumControl,
                ),
                Text(
                  'Expiry date',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: VisaField(
                        hint: 'month*',
                        textEditingController: _monthControl,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text('/',style: TextStyle(fontSize: 30),),
                    SizedBox(width: 10,),
                    Flexible(
                      child: VisaField(
                        hint: 'year*',
                        textEditingController: _yearControl,
                      ),
                    ),
                  ],
                ),
                VisaField(
                  textInputType: TextInputType.name,
                  lable: 'Card holder\'s first name',
                  textEditingController: _fNameControl,
                ),
                VisaField(
                  textInputType: TextInputType.name,
                  lable: 'Card holder\'s first name',
                  textEditingController: _lNameControl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer(Size size, String image) {
    return Flexible(
      child: Container(
        width: 150,
        height: 100,
        child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
