import 'package:carwash/consts/const_colors.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String hint;
  final String? Function(dynamic value) validetor;
  final bool? isPass;
  final Widget? sufix;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final bool? enabled;
  final String? lable;

  const DefaultTextField(
      {Key? key,
        this.lable,
        this.enabled=true,
        this.textInputType=TextInputType.text,
        required this.hint,
        required this.validetor,
        this.isPass = false,
        this.sufix,
        required this.textEditingController,
        this.focusNode,
        this.nextFocusNode,
        this.textInputAction=TextInputAction.next,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onEditingComplete: (){
        if (nextFocusNode!=null)
         {
           FocusScope.of(context).requestFocus(nextFocusNode);
         }
        if(textInputAction== TextInputAction.done)
          FocusScope.of(context).unfocus();
      },
      style: TextStyle(fontSize: 20, color: Colors.black),
      keyboardType: textInputType,
      validator: (v) => validetor(v),
      obscureText: isPass!,
      controller:textEditingController,
      decoration: InputDecoration(
        labelText: lable,
          labelStyle: lable!=null?TextStyle(
            fontSize: 18,
            color: Kblack,
          ):null,
          suffixIcon: sufix,
          hintText: hint,
          hintStyle:lable==null? TextStyle(
            fontSize: 18,
            color: Colors.black,
          ):TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
          disabledBorder: buildUnderlineInputBorder(Colors.black),
          enabledBorder: buildUnderlineInputBorder(Colors.black),
          focusedBorder: buildUnderlineInputBorder(KbtnColor),
          errorBorder: buildUnderlineInputBorder(Colors.red)),
    );
  }

  UnderlineInputBorder buildUnderlineInputBorder(color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
