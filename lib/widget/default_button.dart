import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function function;
  final String text;
  final double fontSize;
  final Color color ;

  const DefaultButton({
    Key? key,
    required this.function,
    required this.text,
    this.fontSize=18,
    this.color=KbtnColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: MaterialButton(
        onPressed: () => function(),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: fontSize
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
