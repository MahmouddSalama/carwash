import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';
class VisaField extends StatelessWidget {
  final String? lable;
  final String? hint;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;

  const VisaField({Key? key,this.textInputType=TextInputType.number,this.hint, this.lable,required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(lable!=null)
          Text(
            lable!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5,),
          Container(
            width: size.width,
            height: 40,
            decoration: BoxDecoration(
                color: Kwhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey,width: 1)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(fontSize: 20,),
                textAlign:hint!=null? TextAlign.center:TextAlign.start,
                keyboardType:textInputType,
                decoration: InputDecoration(
                  hintText: hint,
                    hintStyle: TextStyle(fontSize: 18,color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
