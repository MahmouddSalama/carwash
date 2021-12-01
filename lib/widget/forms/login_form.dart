import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/auth/ui/forget_mypass.dart';
import 'package:carwash/screens/auth/ui/register_screen.dart';
import 'package:carwash/screens/bodyGarage/bodys/main_layout/main_lauout.dart';
import 'package:carwash/widget/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              hint: 'Email',
              validetor: (v) {
                if (v.toString().isEmpty)
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
            Align(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => ForgetPassScreen()));
                },
                child: Text(
                  "Forget My Password",
                  style:
                      TextStyle(color: KtextColor, fontWeight: FontWeight.bold),
                ),
              ),
              alignment: Alignment.centerRight,
            ),
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                qustion: 'Don\'t have account',
                operation: 'Register',
              ),
            ),
            SizedBox(height: 50),
            loading
                ? Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: KbtnColor,
                    ),
                  )
                : DefaultButton(
                    text: 'Login',
                    function: () {
                      _login();
                    },
                  ),
          ],
        ),
      ),
    );
  }
  _login()async{
    String error='';
    if(_formKey.currentState!.validate()){
      try {
        setState(() {
          loading=true;
        });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailControlle.text.toLowerCase().trim().toString(),
          password: _passControlle.text.trim().toString(),
        );
        Navigator.canPop(context)?Navigator.pop(context):null;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>MainLayoutGarage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading=false;
        });
        if (e.code == 'user-not-found') {
          error='No user found for that email.';
        } else if (e.code == 'wrong-password') {
          error='Wrong password provided for that user.';
        }
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text('InValid data'),
          content:Text(error,style: TextStyle(fontSize: 18,color: Colors.red),),
          actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text('ok'))],
        ));
      }catch (e) {
        //print(e);
      }
    }
    setState(() {
      loading=false;
    });

  }
}
