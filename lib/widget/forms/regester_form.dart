import 'dart:io';

import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/auth/ui/signin_screen.dart';
import 'package:carwash/screens/bodyGarage/bodys/main_layout/main_lauout.dart';
import 'package:carwash/widget/texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _userTypeControlle = TextEditingController();
  final _phoneControlle = TextEditingController();

  // FocusNodes
  FocusNode _fullnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _confirmPassNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  List carsType = [
    'Chose type',
    'Garage Owner',
    'tradetional User'
  ];

  String dropdownValue = 'Chose type';
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
          SizedBox(height: 10),
          Container(
            width: size.width,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom:BorderSide(width: 1,color: Colors.black)
                ),

            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              style: TextStyle(
                  color: KtextColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              isExpanded: true,
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
          SizedBox(height: 50),
         loading? Container(
           width: 50,
           height: 50,
           child: CircularProgressIndicator(color: KbtnColor,),
         ): DefaultButton(text: 'Sign Up',
             function: () {
           _signUp();
              }
          ),
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
  _signUp()async{
    String error = '';
    if(_formKey.currentState!.validate()){
      if(dropdownValue=='Chose type'){
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('pleas chose user typ',style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        loading = true;
      });
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailControlle.text.toLowerCase().trim(),
          password: _passControlle.text.trim(),
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'id': FirebaseAuth.instance.currentUser!.uid,
          'name': _nameControlle.text,
          'email': _emailControlle.text,
          'type':dropdownValue,
          'phoneNum': _phoneControlle.text,
          'createdAt': Timestamp.now(),
          'admin': false,
          'password':_passControlle.text,
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => MainLayoutGarage()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'weak-password') {
          error = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          error = 'The account already exists for that email.';
        }
        _showErrorDialog('error is${e.toString()}');
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      loading = false;
    });
    }
  _showErrorDialog(error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('InValid data'),
        content: Text(
          error,
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ok'))
        ],
      ),
    );
  }
}
