import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 23,
        color: Colors.white,
      ),
    );
  }
}

class TogelText extends StatelessWidget {
  final String qustion;
  final String operation;
  final Function function;


  const TogelText({Key? key,required this.qustion,required this.operation,required this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: '$qustion   ',
            style: TextStyle(fontSize: 18, color: Colors.black)),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () => function(),
          text: operation,
          style: TextStyle(
              fontSize: 18,
              color: Colors.blue,
              decoration: TextDecoration.underline),
        ),
      ]),
    );
  }
}
