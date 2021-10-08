import 'package:carwash/widget/forms/login_form.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/material.dart';
class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: ListView(
            children: [
              Logo(),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
