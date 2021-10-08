import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/auth/ui/register_screen.dart';
import 'package:carwash/screens/body/main_lauout.dart';
import 'package:carwash/widget/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../default_button.dart';
import '../default_text_fields.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool checkValue = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();

  //vars
  bool obsecure = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  //TextEditingController
  final _emailControlle = TextEditingController();
  final _passControlle = TextEditingController();

  void dispose() {
    _passControlle.dispose();
    _emailControlle.dispose();
    _passFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextField(
              focusNode: _emailFocusNode,
              nextFocusNode: _passFocusNode,
              textEditingController: _emailControlle,
              hint: 'Phone Number',
              validetor: (v) {
                if (v.toString().isEmpty || v.toString().length > 11)
                  return 'Enter valid Phone Number';
              },
            ),
            SizedBox(height: 10),
            DefaultTextField(
              focusNode: _passFocusNode,
              textInputAction: TextInputAction.done,
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
            Row(
              children: [
                Checkbox(
                    value: checkValue,
                    onChanged: (v) {
                      setState(() {
                        checkValue = v!;
                      });
                    }),
                Text(
                  'Remember me',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TogelText(
                function: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                },
                qustion: 'Don\'t have account',
                operation: 'Register',
              ),
            ),
            SizedBox(height: 50),
            loading? Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(color: KbtnColor,),
            ):  DefaultButton(
              text: 'Login',
              function: () {
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
                },
            ),
          ],
        ),
      ),
    );
  }
}
