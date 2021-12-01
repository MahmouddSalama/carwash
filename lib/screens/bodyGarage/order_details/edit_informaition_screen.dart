import 'package:carwash/widget/default_button.dart';
import 'package:carwash/widget/default_text_fields.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/material.dart';

import 'order_details_payment.dart';
class EditInformationScreen extends StatelessWidget {
  var _nameControll = TextEditingController();
  var _phoneControll = TextEditingController();
  var _emailControll = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Logo(),
            DefaultTextField(
              focusNode: _nameNode,
              nextFocusNode: _phoneNode,
              hint: 'user name',
              validetor: (v) {},
              textEditingController: _nameControll,
              textInputType: TextInputType.name,
              lable: 'Name',
            ),
            DefaultTextField(
              focusNode: _phoneNode,
              nextFocusNode: _emailNode,
              hint: '0123456789',
              validetor: (v) {},
              textEditingController: _phoneControll,
              textInputType: TextInputType.name,
              lable: 'Phone',
              textInputAction: TextInputAction.done,
            ),
            DefaultTextField(
              focusNode: _emailNode,
              hint: 'user@gmail.com',
              validetor: (v) {},
              textEditingController: _emailControll,
              textInputType: TextInputType.name,
              lable: 'Email',
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 40),
            DefaultButton(
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderDetailsPayment()));
              },
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }
}
