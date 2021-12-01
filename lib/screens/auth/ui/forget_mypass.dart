
import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPassScreen extends StatelessWidget {

  final _emailControlle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: size.height * .1),
            DefaultTextField(
              textEditingController: _emailControlle,
              textInputType: TextInputType.emailAddress,
              hint: 'Email',
              validetor: (v) {
                if (v.toString().isEmpty&&!v.toString().contains('@'))
                  return 'enter valid email';
              },
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .15, vertical: 20),
              child: DefaultButton(
                function: () {
                  FocusScope.of(context).unfocus();
                  _forgetPass(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 15,
                      backgroundColor: Colors.white,
                      content: Text('we well send email to you pleas chick your email',style: TextStyle(
                        color: Colors.blue,
                      ),),
                    ),
                  );
                },
                text: 'ارسال',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _forgetPass(ctx)async {

  }
}
