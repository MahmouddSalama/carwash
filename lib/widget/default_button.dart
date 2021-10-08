import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function function;
  final String text;


  const DefaultButton({
    Key? key,
    required this.function,
    required this.text,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: MaterialButton(
        onPressed: () => function(),
        color: KbtnColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 20
              ),),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
