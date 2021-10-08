import 'dart:io';

import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/body/main_lauout.dart';
import 'package:carwash/widget/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../default_button.dart';
import '../default_text_fields.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  //vars
  bool obsecure = true;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // TextEditingController
  final _emailControlle = TextEditingController();
  final _nameControlle = TextEditingController();
  final _passControlle = TextEditingController();
  final _confirmpassControlle = TextEditingController();
  final _phoneControlle = TextEditingController();

  // FocusNodes
  FocusNode _fullnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _confirmPassNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  void dispose() {
    // TODO: implement dispose
    _emailControlle.dispose();
    _passControlle.dispose();
    _nameControlle.dispose();
    _confirmpassControlle.dispose();
    _phoneControlle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DefaultTextField(
            focusNode: _fullnameFocusNode,
            nextFocusNode: _phoneFocusNode,
            textEditingController: _nameControlle,
            hint: 'Name',
            validetor: (v) {
              if (v.toString().isEmpty) return 'Enter valid name';
            },
          ),
          SizedBox(height: 10),
          DefaultTextField(
            textInputType: TextInputType.phone,
            focusNode: _phoneFocusNode,
            nextFocusNode: _emailFocusNode,
            textEditingController: _phoneControlle,
            hint: 'Mobile',
            validetor: (v) {
              if (v.toString().isEmpty || v.toString().length > 11)
                return 'Enter valid phone number';
            },
          ),
          SizedBox(height: 10),
          DefaultTextField(
            textInputType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            nextFocusNode: _passFocusNode,
            textEditingController: _emailControlle,
            hint: 'Mail',
            validetor: (v) {
              if (v.toString().isEmpty || !v.toString().contains("@"))
                return 'Enter valid email';
            },
          ),
          SizedBox(height: 10),
          DefaultTextField(
            textInputType: TextInputType.visiblePassword,
            focusNode: _passFocusNode,
            nextFocusNode: _confirmPassNode,
            textEditingController: _passControlle,
            hint: 'Password',
            validetor: (v) {
              if (v.toString().isEmpty || v.toString().length < 7)
                return 'pass must be more than 7 liters';
            },
            isPass: obsecure,
            sufix: IconButton(
              onPressed: () {
                setState(() {
                  obsecure = !obsecure;
                });
              },
              icon: Icon(
                obsecure ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          DefaultTextField(
            textInputType: TextInputType.visiblePassword,
            focusNode: _confirmPassNode,
            textInputAction: TextInputAction.done,
            textEditingController: _confirmpassControlle,
            hint: 'Confirm Password',
            isPass: true,
            validetor: (v) {
              if (v.toString().isEmpty) return 'Enter valid position';
            },
          ),
          SizedBox(height: 50),
         loading? Container(
           width: 50,
           height: 50,
           child: CircularProgressIndicator(color: KbtnColor,),
         ): DefaultButton(text: 'Sign Up', function: (){
            setState(() {
              loading=true;
            });
            Future.delayed(Duration(seconds: 2),(){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx)=>MainLayout()));
            }).then((value){
              setState(() {
                loading=false;
              });
            });

          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TogelText(qustion: 'I have An Account', operation: 'Sign in', function: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
            }),
          )
        ],
      ),
    );
  }
}
